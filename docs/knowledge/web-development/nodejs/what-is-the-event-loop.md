# The Node.js Event Loop, Timers, and `process.nextTick()`

<hr/>

## What is the Event Loop?

The event loop is what allows Node.js to perform non-blocking I/O operations - despite the fact that JavaScript is single-threaded - by offloading operations to the system kernel whenever possible.

Since most modern kernels are multi-threaded, they can handle multiple operations executing in the background. When on of these operations completes, the kernel tells Node.js so that the appropriate callback may be added to the **_poll_** queue to eventually be executed.

## Event Loop Explained

When Node.js starts, it initializes the event loop, processes the provided input script (or drops into the [REPL](https://nodejs.org/api/repl.html#repl_repl), which is not covered in this document) which may make async API calls, schedule timers, or call `process.nextTick()`, then begins processing the event loop.

The following diagram shows a simplified overview of the event loop's order of operations.

    ┌───────────────────────────┐
    ┌─>│ timers │
    │ └─────────────┬─────────────┘
    │ ┌─────────────┴─────────────┐
    │ │ pending callbacks │
    │ └─────────────┬─────────────┘
    │ ┌─────────────┴─────────────┐
    │ │ idle, prepare │
    │ └─────────────┬─────────────┘ ┌───────────────┐
    │ ┌─────────────┴─────────────┐ │ incoming: │
    │ │ poll │<─────┤ connections, │
    │ └─────────────┬─────────────┘ │ data, etc. │
    │ ┌─────────────┴─────────────┐ └───────────────┘
    │ │ check │
    │ └─────────────┬─────────────┘
    │ ┌─────────────┴─────────────┐
    └──┤ close callbacks │
    └───────────────────────────┘

_note: each box will be referred to as a "phase" of the event loop._

Each phase has a FIFO queuse of callbacks to execte. While each phase is special in its own way, generally, when the event loop enters a given phase, it will perform any operations specific to that phase, then execute callbacks in that phase's quese until the queue has been exhausted or the maximum number of callbacks has executed. When the queue has been exhausted or the callback limit is reached, the event loop will move to the next phase, and so on.

Since any of these operations may schedule more operations and new events processed in the **_poll_** phase are queued by the kernel, poll events can be queued while polling events are being processed. As a result, long running callbacks can allow the poll phase to run much longer than timers's threshold. See the **_timers_** and **_poll_** sections for more details.

**_NOTE_**: There is a slight discrepency between the Windows and the Unix/Linux implementation, but that's not important for this demonstration. There are actually seven or eight steps, but the ones we care about - ones that Node.js actuall uses - are those above.

## Phases Overview

- **_timers_**: this phase executes callbacks scheduled by `setTimeout()` and `setInterval()`.
- **_pending callbacks_**: executes I/O callbacks deferred to the next loop iteration.
- **_idle, prepare_**: only used internally.
- **_poll_**: retrieve new I/O events; execute I/O related callbacks(almost all with the exception of close callbacks, the ones scheduled by timers, and `setImmediate()`); node will block here when appropriate.
- **_check_**: `setImmediate()` callbacks are invoked here.
- **_close callbacks_**: some close callbacks, e.g `socket.on('close', ...)`.

## Phases in Detail

### timers

A timers specifies the **_threshold_** after which a provided callback my be executed rather than the **_exact_** time a person wants it to be executed. Timers callbacks will run as early as they can be scheduled after the specified amount of time has passed; however, Operating System scheduling or the running of other callbacks may delay them.

**_Note_**: \*Technically, the **_poll_** phase controls when timers are executed.\*

Note: To prevent the **_poll_** phase from starving the event loop, [libuv](http://libuv.org/) (the C library that implements the Node.js event loop and all of the asynchronous behaviors of the platform) also has a hard maximum (system dependent) before it stops polling for more events.

### pending callbacks

This phase executes callbacks for some system operations such as types of TCP errors. For example if a TCP socket receives `ECONNREFUSED` when attempting to connect, some \*nix systems want to wait to report the error. This will be queused to execute the **_pending callbacks_** phase.

### poll

The **_poll_** phase has two main functions:

1. Calculating how long it should block and poll for I/O, then
2. Processing events in the **_poll_** queue.

Once the **_poll_** queue is empty the event loop will check for timers whose time thresholds have been reached. If one or more timers are ready, the event loop will wrap back to the **_timers_** phase to execute those timers's callbacks.

### check

This phase allows a person to execute callbacks immediately after the **_poll_** phase has completed. If the **_poll_** phase becomes idle and scripts have been queued with `setImmediate()`, the event loop may contimue to the **_check_** phase rether than waiting.

`setImmediate()` is actually a special timer that runs in a separate phase of the event loop. It uses a libuv API that schedules callbacks to execute after the **_poll_** phase has completed.

### close callbacks

if a socket or handle is closed abruptly (e.g `socket.destroy()`), the `'close'` event will be emitted in this phase. Otherwise it will be emitted via `process.nextTick()`.

The main advantage to using `setImmediate()` over `setTimeout()` is `setImmediate()` will always be executed before any timers if scheduled within an I/O cycle, independently of how many timers are present.

`process.nextTick()` was not displayed in the diagram, even though it's a part of the asynchromous API. This is because `process.nextTick` is not technically part of the event loop. Instead, the `nextTickQueue` will be processed after the current operation is completed, regardless of the current phase of the event loop. Here, and operation is defined as a transition from the underlying C/C++ handler, and handing the JavaScript that needs to be executed.

### Why use `process.nextTick()`?

There are two main reasons:

1. Allow users to handle errors, cleanup any then unneeded resources, or perhaps try the request again before the event loop continues.
2. At times it's necessay to allow a callback to run after the call stack has unwound but before the event loop continues.

<hr/>

Get more information at [here](https://nodejs.org/en/docs/guides/event-loop-timers-and-nexttick/).

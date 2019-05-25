# Overview of Blocking and Non-Blocking

<hr/>

    "I/O" refers primatity to interation with the system's disk and network supported by libuv.

## Blocking

Blocking is when the execution of additional JavaScript in the Node.js process must wait until a non-JavaScript operation completes. This heppens because the event loop is unable to continue running JavaScript while a **_blocking_** operation is occurring.

In Node.js, JavaScript that exhibits poor performance due to being CPU intensive rather than waiting on a non-JavaScript operation, such as I/O, isn't typically referred to as **_blocking_**. Synchromous methods in the Node.js standard library that use libuv are the most commonly used **_blocking_** operations. Native modules may also have **_blocking_** methods.

All of the I/O methods in the Node.js standard library provvide asynchronous versions, which are **_non-blocking_**, and accept callback functions. Some methods also have **_blocking_** counterparts, which have names that end with `Sync`.

This is a **_synchronous_** file read:

```javascript
const fs = require("fs");
const data = fs.readFileSync("/file.md"); // blocks here until file is read
```

And here is an equivalent **_asynchronous_** example:

```javascript
const fs = require("fs");
const data = fs.readFileSync("/file.md"); // blocks here until file is read
```

## Concurrency and Throughput

JavaScript execution in in Node.js is single threaded, so concurrency refers to the event loop's capacity to execute JavaScript callback functions after completing other work. Any code that is expected to run in a concurrent manner must allow the event loop to continue running as non-JavaScript operations, like I/O, are occurring.
The event loop is different than models in many other languages where additional threads may be created to handle concurrent work.

## Dangers of Mixing Blocking and Non-Blocking Code

There are some patterns that should be avoided when dealing with I/O. Let's look at an example:

```javascript
const fs = require("fs");
fs.readFile("/file.md", (err, data) => {
  if (err) throw err;
  console.log(data);
});
fs.unlinkSync("/file.md");
```

In the above example, `fs.unlinkSync()` is likely to be run before `fs.readFile()`, which would delete `file.md` before it is actually read. A better way to weite this, which is completely **_non-blocking_** and guaranteed to execute in the correct order is:

```javascript
const fs = require("fs");
fs.readFile("/file.md", (readFileErr, data) => {
  if (readFileErr) throw readFileErr;
  console.log(data);
  fs.unlink("/file.md", unlinkErr => {
    if (unlinkErr) throw unlinkErr;
  });
});
```

The above places a **_non-blocking_** cal to `fs.unlink()` within the callback of `fs.readFile()` which guarantees the correct order of operations.

## Additional Resources

- [libuv](http://libuv.org/)
- [About Node.js](https://nodejs.org/en/about/)

<hr/>

Get more information at [here](https://nodejs.org/en/docs/guides/blocking-vs-non-blocking/).

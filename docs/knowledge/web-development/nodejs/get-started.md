# Get started in Nodejs

<hr/>

## How to exit from a Nodejs program

The `process` core module provides a handy method that allows you to programmatically exit from a Node.js program: `process.exit()`.

This means that any callback that's pending, any network request still being sent, any filesystem access, or processes writing to `stdout` or `stderr` - all is going to be ungracefully terminated right away.

```javascript
process.exit(1);
```

you can read more on exit codes at [here](https://nodejs.org/api/process.html#process_exit_codes).

Note: `process` does not require a "require", it's automatically available.

```javascript
const express = require("express");

const app = express();

app.get("/", (req, res) => {
  res.send("Hi!");
});

const server = app.listen(3000, () => console.log("Server ready"));

process.on("SIGTERM", () => {
  server.close(() => {
    console.log("Process terminated");
  });
});
```

`SIGKILL` is the signal that tells a process to immediately terminate, and would ideally act like `process.exit()`.

`SIGTERM` is the signal that tells a process to gracefully terminate. It is the signal that's sent from process managers like `upstart` or `supervisord` and many others.

```javascript
process.kill(process.pid, "SIGTERM");
```

<hr/>

Get more information at [here](https://nodejs.dev/).

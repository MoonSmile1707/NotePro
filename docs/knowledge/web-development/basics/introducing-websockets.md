# Introducing WebSockets: Bringing Sockets to the Web

The [WebSocket](http://dev.w3.org/html5/websockets/) specification defines and API establishing "socket" connections between a web browser and a server. In plain words: There is an persistent connection between the client and the server and both parties can start sending data at any time.

<hr/>

## Getting Started

You open up a WebSocket connection simply by calling the WebSocket constructor:

```javascript
var connection = new WebSocket('ws://html5rocks.websocket.org/echo', ['soap', 'xmpp'])
```

Attaching some event handlers immediately to the connection allows you to know when the connection is opened, received incomimg messages, or there is an error.

The second argument accepts optional subprotocols. It can be a string or array of strings. Each strng should represent a subprotocol name and server accepts only one of passes subprotocols in the array. Accepted subprotocol can be determined by accessing protocol property of WebSocket object.

The subprotocol names must be one of registered subprotocol names in [IANA registry](http://www.iana.org/assignments/websocket/websocket.xml). There is currently only one subprotocol name (soap) registered as of February 2012.

```javascript
// When the connection is open, send some data to the server
connection.onopen = function () {
  connection.send('Ping'); // Send the message 'Ping' to the server
};

// Log errors
connection.onerror = function (error) {
  console.log('WebSocket Error ' + error);
};

// Log messages from the server
connection.onmessage = function (e) {
  console.log('Server: ' + e.data);
};
```

## Communicating with the Server

As soon as we have a connection to the server (when the open event is fired) we can start sending data to the server using the `send('your mess')` method on the connection object. It used to support only strings, but in the latest spec it now can send binary messages too. To send binary data, you can use either `Blob` or `ArrayBuffer` object.

```javascript
// Sending String
connection.send('your message');

// Sending canvas ImageData as ArrayBuffer
var img = canvas_context.getImageData(0, 0, 400, 320);
var binary = new Uint8Array(img.data.length);
for (var i = 0; i < img.data.length; i++) {
  binary[i] = img.data[i];
}
connection.send(binary.buffer);

// Sending file as Blob
var file = document.querySelector('input[type="file"]').files[0];
connection.send(file);
```

Equally the server might send us messages at any time. Whenever this happens the `onmessage` callback fires. The callback receives an event object and the actual message is accessible via the `data` property.

WebSocket can also receive binary messages in the latest spec. Binary frames can be received in `Blob` or `ArrayBuffer` format. To specify the format of the received binary, set the binaryType property of WebSocket object to either 'blob' or 'arraybuffer'. The default format is 'blob'. (You don't have to align binaryType param on sending.)

```javascript
// Setting binaryType to accept received binary as either 'blob' or 'arraybuffer'
connection.binaryType = 'arraybuffer';
connection.onmessage = function(e) {
  console.log(e.data.byteLength); // ArrayBuffer object if binary
};
```

Another newly added feature of WebSocket is extensions. using extensions, it will be possible to send frames [compressed](http://tools.ietf.org/html/draft-tyoshino-hybi-websocket-perframe-deflate-05), [multiplexed](http://tools.ietf.org/html/draft-tamplin-hybi-google-mux-02), etc. You can find server accepted extensions by examining the extensions property of the WebSocket object after the open event. There is no officially published extentions spec just yet as of February 2012,

```javascript
// Determining accepted extensions
console.log(connection.extensions);
```

## Cross Origin Communication

Being a modern protocol, cross origin comminication is baked right into WebSOcket. While you should still make sure only to comunicate with clients and servers that you trust, WebSocket enables communication between parties on any domain. The server decides whether to make its service available to all clients or only those that reside on a set of well defined domains.

## Proxy Servers

Every new teachnology comes with a new set of problems. In the case of WebSocket it is the compatibility with proxe servers with meditate HTTP connections in most company networks. The WebSocket protocol uses the HTTP upgrade system (twhich is normally used for HTTP/SSL) to "upgrade" and HTTP connection to a WebSocket conneciton. Some proxy servers do not like this and will drop the connection. Thus, even if a given client uses the WebSocket protocol, it may not be possible to establist a connection. This makes the next section even more important.

## Use WebSockets Today

WebSocket is still a young technology and not fully implemented in all browsers. However, you can use WebSocket today with libraries that use one of the [fallbacks](https://www.html5rocks.com/en/tutorials/websockets/basics/#fallbacks) mentioned above whenever WebSocket is not available. A library that has become very popular in this domain is [socket.io](http://socket.io/) which comes with a client and a server implementation of the protocol and includes fallbacks (socket.io doesn't support binary messaging yet as of Februrary 2012). There are also commercial solutions such as [PusherApp](http://pusherapp.com/) which can be easily integrated into any web enviroment by providing a HTTP API to send WebSocket messages to clients. Due to the extra HTTP request there will always be extra overhead compared to pure WebSocket.

## The Server Side

Using WebSocket creates a whole new usage pattern for server side applications. While traditional server stacks such LAMP are designed around the HTTP request/response cycle they often do not deal well with a large number of open WebSocket connections. Keeping a large number of connections open at the same time requires an architecture that receives high concurrency at a low performance cost. Such architectures are usually designed around either threading or so callled non-blocking IO.

## Server Side Implementations

- Node.js
  - [Socket.IO](http://socket.io/)
  - [WebSocket-Node](https://github.com/Worlize/WebSocket-Node)
  - [ws](https://github.com/einaros/ws)
- Java
  - [Jetty](http://www.eclipse.org/jetty/)
- Ruby
  - [EventMachine](http://github.com/igrigorik/em-websocket)
- Python
  - [pywebsocket](http://code.google.com/p/pywebsocket/)
  - [Tornado](https://github.com/facebook/tornado)
- Erlang
  - [Shirasu](https://github.com/michilu/shirasu)
- C++
  - [libwebsockets](http://git.warmcat.com/cgi-bin/cgit/libwebsockets/)
- .NET
  - [SuperWebSocket](http://superwebsocket.codeplex.com/)

## Use Cases

Use WebSocket whenever you need a truly low latency, near realtime connection between the client and the server. Keep in mind that this might involve rethinking ho you build your server side applications with a new foces on technologies such as event queues. Some example use cases are:

- Multiplayer online games
- Chat applications
- Live sports ticker
- Realtime updating social streams

## References

- [The WebSocket API](http://dev.w3.org/html5/websockets/)
- [The WebSocket Protocol](http://tools.ietf.org/html/draft-ietf-hybi-thewebsocketprotocol-03)
- [WebSockets-MDN](https://developer.mozilla.org/en/WebSockets)

<hr/>

Get more information at [here](https://www.html5rocks.com/en/tutorials/websockets/basics/).

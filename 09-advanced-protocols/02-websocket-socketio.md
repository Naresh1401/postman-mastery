# 9.2 WebSocket and Socket.IO Requests

## Why Postman Supports These

REST request/response doesn't cover **real-time, bidirectional** communication (chat apps, live dashboards, trading tickers). Postman added native **WebSocket** and **Socket.IO** request types so you can test these without writing a custom client script.

## WebSocket Requests

1. **New → WebSocket Request**.
2. Enter a `ws://` or `wss://` URL.
3. Click **Connect** — establishes a persistent connection.
4. Use the **Message** pane to send text/JSON/binary frames to the server at any time while connected.
5. Incoming messages from the server appear in a live, timestamped **message log** pane.

### Example
```
Connect to: wss://echo.websocket.org

Send: { "type": "subscribe", "channel": "prices" }
→ (server pushes messages asynchronously, shown in the log as they arrive)

Send: { "type": "ping" }
→ Receive: { "type": "pong" }
```

### Scripting for WebSocket

- **Pre-request Script** runs once before connecting.
- You can attach event-driven scripts to run **on each received message** to assert things in near-real-time (e.g., "the first message received must be a `welcome` event").

## Socket.IO Requests

**Socket.IO** is a popular library built on top of WebSocket (with fallbacks to long-polling) that adds its own framing/event protocol — a raw WebSocket client can't just "talk" Socket.IO without implementing its handshake. Postman has a **dedicated Socket.IO request type** that understands this protocol natively.

1. **New → Socket.IO Request**.
2. Enter the server URL.
3. Specify the **namespace** (default `/`) if your server uses custom namespaces.
4. **Connect** — Postman performs the Socket.IO handshake automatically.
5. **Emit events** by name with a payload:
```
Event name: joinRoom
Payload: { "roomId": "lobby" }
```
6. **Listen** for specific event names — incoming events matching a name you're subscribed to appear in the log, parsed and labeled by event name (not just raw frames like plain WebSocket).

## When to Use Which

| Protocol | Use when |
|---|---|
| Raw WebSocket | The server speaks plain WebSocket framing directly (no Socket.IO library on the server) |
| Socket.IO | The server is built with the Socket.IO library (common in Node.js real-time apps) — you need the specific handshake/event protocol it uses |

## Common Debugging Tips

- If **Connect** fails immediately, check: correct scheme (`ws`/`wss` vs `http`/`https`), any required auth (some WS servers expect a token as a query param or in an `Authorization` header sent during the HTTP upgrade handshake), and whether the server requires a specific `Origin` header.
- Use the message log's timestamps to diagnose latency/ordering issues in real-time protocols.

## Practice Exercise

1. Connect a **WebSocket Request** to `wss://echo.websocket.org` (a public echo WS server).
2. Send a text message `hello postman` and confirm it's echoed back in the log.
3. Note the difference in setup complexity compared to a Socket.IO server requiring namespace/handshake configuration.

Continue to → [9.3 gRPC](03-grpc.md)

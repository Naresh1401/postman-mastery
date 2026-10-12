# 9.3 gRPC in Postman

## What gRPC Is (Quick Primer)

**gRPC** is a high-performance RPC framework from Google, using:
- **Protocol Buffers (protobuf)** for a compact, strongly-typed binary message format.
- **HTTP/2** as the transport (enabling multiplexing and streaming).
- Service definitions in `.proto` files describing available RPC methods, request/response message shapes.

Unlike REST, you can't just "guess" the body format from documentation alone — gRPC is **schema-first**, so Postman needs the `.proto` definition to know how to construct/parse messages.

## Creating a gRPC Request

1. **New → gRPC Request**.
2. Enter the **server URL** (host:port, e.g., `localhost:50051`) — no `http://` scheme, gRPC uses HTTP/2 directly.
3. **Import the `.proto` file(s)** defining the service: either upload the file, paste the server reflection endpoint (if the server supports **gRPC Server Reflection**, Postman can auto-discover services without a manual `.proto` upload), or point at a local path.
4. Select the **Service** and **Method** from the dropdown (populated from the imported proto).
5. Fill in the **Message** pane — Postman generates a JSON-like editable template matching the proto message's exact fields/types, including nested messages and enums with autocomplete.
6. Click **Invoke** to make a unary call, or appropriate streaming controls for streaming methods.

## The 4 gRPC Call Types Postman Supports

| Type | Description | UI behavior |
|---|---|---|
| **Unary** | One request → one response (like a typical REST call) | Single Invoke button, single response |
| **Server Streaming** | One request → stream of responses | Invoke once, responses stream into a live log as the server sends them |
| **Client Streaming** | Stream of requests → one response | Send multiple messages over time, then signal "done" to get the final response |
| **Bidirectional Streaming** | Both sides stream independently | Send and receive messages concurrently over the same open call |

## Metadata (gRPC's Equivalent of Headers)

gRPC calls support **Metadata** — key/value pairs similar to HTTP headers, used for things like auth tokens:
```
authorization: Bearer {{accessToken}}
```
Set these in the **Metadata** tab of the gRPC request, same pattern as REST Headers.

## TLS / Server Reflection Settings

- gRPC servers commonly use **TLS** — Postman's gRPC request has a toggle for **Use TLS**, plus options for client certificates if mutual TLS (mTLS) is required.
- If the server supports **Server Reflection**, you don't need to manually import `.proto` files at all — Postman queries the server directly for its available services/methods/message schemas.

## Scripting Support

- **Pre-request scripts** run before the call is invoked (same `pm` API, works the same as REST).
- Response assertions use the same `pm.test()`/`pm.expect()` pattern, operating on the deserialized message object Postman gives you (no manual protobuf parsing needed).

## Practice Exercise (Conceptual)

If you have access to a local/sample gRPC server (e.g., the standard `grpc` `helloworld` example server):
1. Run it locally on `localhost:50051`.
2. In Postman, create a gRPC request pointing at that address, import its `.proto` (or use reflection if enabled).
3. Invoke the `SayHello` unary method with a `name` field and confirm you get a greeting message back.

Continue to → [9.4 MQTT and SOAP](04-mqtt-soap.md)

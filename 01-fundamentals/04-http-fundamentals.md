# 1.4 HTTP Fundamentals (Everything Postman Is Built On)

Postman is a GUI over HTTP. To use it well, you need to understand what's actually happening on the wire.

## Anatomy of an HTTP Request

```
GET /users/42?active=true HTTP/1.1
Host: api.example.com
Authorization: Bearer eyJhbGciOi...
Content-Type: application/json
Accept: application/json

{ "optional": "body for POST/PUT/PATCH" }
```

- **Method** — the verb/action (`GET`, `POST`, ...).
- **Path + Query String** — the resource and filters.
- **Headers** — metadata (auth, content type, caching directives, custom headers).
- **Body** — payload, typically present for `POST`/`PUT`/`PATCH`, usually absent for `GET`/`DELETE`.

## HTTP Methods

| Method | Purpose | Idempotent? | Has Body? | Safe (no side effects)? |
|---|---|---|---|---|
| `GET` | Retrieve a resource | Yes | No (shouldn't) | Yes |
| `POST` | Create a resource / trigger an action | No | Yes | No |
| `PUT` | Replace a resource entirely | Yes | Yes | No |
| `PATCH` | Partially update a resource | No (in practice, often treated as yes) | Yes | No |
| `DELETE` | Remove a resource | Yes | Usually no | No |
| `HEAD` | Like GET but headers only, no body | Yes | No | Yes |
| `OPTIONS` | Discover allowed methods/CORS preflight | Yes | No | Yes |

**Idempotent** = calling it multiple times has the same effect as calling it once (important for retries).

## HTTP Status Codes

| Range | Category | Common codes |
|---|---|---|
| `1xx` | Informational | `100 Continue` |
| `2xx` | Success | `200 OK`, `201 Created`, `202 Accepted`, `204 No Content` |
| `3xx` | Redirection | `301 Moved Permanently`, `302 Found`, `304 Not Modified` |
| `4xx` | Client Error | `400 Bad Request`, `401 Unauthorized`, `403 Forbidden`, `404 Not Found`, `405 Method Not Allowed`, `409 Conflict`, `422 Unprocessable Entity`, `429 Too Many Requests` |
| `5xx` | Server Error | `500 Internal Server Error`, `502 Bad Gateway`, `503 Service Unavailable`, `504 Gateway Timeout` |

> 🔑 `401` = "I don't know who you are" (authentication problem). `403` = "I know who you are, but you're not allowed" (authorization problem). This distinction trips up almost everyone at first.

## Common Headers You'll Use Constantly in Postman

| Header | Direction | Purpose |
|---|---|---|
| `Content-Type` | Request | Tells the server the format of the body (`application/json`, `application/x-www-form-urlencoded`, `multipart/form-data`, etc.) |
| `Accept` | Request | Tells the server what format you want back |
| `Authorization` | Request | Credentials (`Bearer <token>`, `Basic <base64>`, etc.) |
| `User-Agent` | Request | Identifies the client (Postman sets this automatically) |
| `Content-Length` | Both | Size of the body in bytes |
| `Set-Cookie` | Response | Server asking the client to store a cookie |
| `Cache-Control` | Both | Caching directives |
| `ETag` / `If-None-Match` | Both | Conditional requests / caching validation |

## REST Principles (Quick Primer)

REST (Representational State Transfer) is a style, not a protocol:
1. **Resources are nouns, not verbs** — `/users/42`, not `/getUser?id=42`.
2. **Stateless** — each request contains everything the server needs; no server-side session required.
3. **Uses HTTP methods semantically** — `GET` to read, `POST` to create, etc.
4. **Representations** — a resource is usually represented as JSON (sometimes XML).
5. **HATEOAS** (rarely fully implemented in practice) — responses include links to related actions.

## JSON — The Default Body Format

```json
{
  "id": 42,
  "name": "Ada Lovelace",
  "roles": ["admin", "editor"],
  "active": true,
  "metadata": null
}
```

Postman auto-detects and pretty-prints JSON responses, and gives you a **raw / pretty / preview** toggle in the response viewer.

## Query Params vs Path Params vs Body

| Type | Example | When to use |
|---|---|---|
| **Path param** | `/users/{{userId}}` | Identifying a specific resource |
| **Query param** | `/users?active=true&page=2` | Filtering, pagination, sorting, optional flags |
| **Body** | JSON payload | Sending structured data to create/update a resource |

In Postman, path params are written in the URL with a colon (`:userId`) when using the "Path Variables" feature, or simply as `{{userId}}` if it's a collection/environment variable — both show up as editable fields in the **Params** tab.

## CORS (Why It Doesn't Usually Block Postman)

CORS (Cross-Origin Resource Sharing) is a **browser security feature** — it's enforced by browsers, not servers, and not by Postman's native app (since it's not a browser). That's why a request can fail in your frontend JS app due to CORS but work fine in Postman — Postman isn't subject to the same-origin policy. (Postman **Web** + Chrome-extension mode can be affected; the Desktop Agent avoids this.)

Continue to → [Module 02: Building Requests](../02-building-requests/01-request-methods.md)

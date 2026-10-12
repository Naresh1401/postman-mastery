# 2.1 Request Methods in Postman

## Creating Your First Request

1. Click **+** (new tab) or **New → HTTP Request**.
2. Choose a method from the dropdown (defaults to `GET`).
3. Type a URL — Postman autocompletes based on your history and saved requests.
4. Click **Send**.

## GET — Retrieve Data

```
GET https://postman-echo.com/get?name=Ada&role=admin
```
- No body.
- Query params appear automatically in the **Params** tab when typed into the URL, and vice versa — they're two-way synced.

## POST — Create / Submit Data

```
POST https://postman-echo.com/post
Content-Type: application/json

{
  "name": "Ada Lovelace",
  "role": "admin"
}
```
- Set the **Body** tab to `raw` + `JSON` (Postman auto-sets the `Content-Type` header for you when you pick the body type from the dropdown).

## PUT — Replace a Resource

```
PUT https://postman-echo.com/put
Content-Type: application/json

{
  "id": 42,
  "name": "Ada Lovelace",
  "role": "superadmin"
}
```
Semantically, PUT should send the **entire** resource representation (even unchanged fields), since it replaces the resource.

## PATCH — Partially Update

```
PATCH https://postman-echo.com/patch
Content-Type: application/json

{
  "role": "superadmin"
}
```
Only the fields that change are sent.

## DELETE — Remove a Resource

```
DELETE https://postman-echo.com/delete?id=42
```
Usually no body; sometimes APIs accept a body with extra context (Postman supports this even though it's non-standard).

## HEAD — Headers Only

Returns the same headers a `GET` would, but no body. Useful for checking if a resource exists / its size / its last-modified date without downloading it.

## OPTIONS — Discover Allowed Actions

```
OPTIONS https://postman-echo.com/get
```
Often returns an `Allow` header listing supported methods. Browsers send this automatically as a "preflight" check before certain cross-origin requests; you can send it manually in Postman to debug CORS issues.

## Custom Methods

Postman lets you type any custom verb (e.g., `PURGE`, `LINK`) via "Custom Method" in the dropdown — useful for non-standard APIs (e.g., CDN cache purges, WebDAV).

## Practice Exercise

Using `https://postman-echo.com`:
1. Send a `GET` to `/get` with two query params of your choice.
2. Send a `POST` to `/post` with a JSON body `{"hello": "world"}`.
3. Compare the `args`, `json`, and `headers` fields in each response — notice how `postman-echo.com` echoes back exactly what you sent. This is why it's the ideal practice target: zero guesswork about what the "real" server received.

Continue to → [2.2 Params and Headers](02-params-and-headers.md)

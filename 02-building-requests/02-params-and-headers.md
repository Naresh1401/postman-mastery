# 2.2 Params and Headers

## Query Parameters

The **Params** tab is a key/value table that stays in sync with the URL's query string.

| Key | Value | Description (optional) |
|---|---|---|
| `page` | `2` | Pagination page number |
| `limit` | `20` | Results per page |
| `active` | `true` | Filter flag |

Typing `?page=2&limit=20` directly into the URL bar auto-populates this table, and editing the table updates the URL — they are the same data, two views.

### Disabling a Param Without Deleting It
Uncheck the checkbox next to a param row to temporarily exclude it from the request while keeping it saved for later — extremely useful while debugging which param is causing an issue.

### Bulk Edit Mode
Click **Bulk Edit** (top-right of the Params/Headers tables) to paste multiple key:value pairs as plain text:
```
page:2
limit:20
active:true
```
Much faster than clicking "add row" repeatedly.

## Path Variables

If your URL contains a colon-prefixed segment, Postman treats it as a path variable:
```
https://api.example.com/users/:userId/orders/:orderId
```
This automatically creates `userId` and `orderId` entries in the **Path Variables** section (below Query Params), where you fill in actual values (or bind them to `{{variables}}`).

> Note: this is different from `{{userId}}` style variables, which are resolved via environment/collection/global scopes (Module 03) and work anywhere in the URL, not just as a `:name` path segment.

## Headers

The **Headers** tab works the same way as Params: a key/value table.

### Headers Postman Adds Automatically
Postman auto-adds several headers you don't see in the table by default (visible via the "hidden headers" toggle or the Console):
- `User-Agent: PostmanRuntime/x.x.x`
- `Accept: */*` (unless you set your own)
- `Accept-Encoding`, `Connection`, `Content-Length` (computed)
- `Host` (derived from the URL)
- `Postman-Token` — a unique GUID per request, used by Postman internally (not security-sensitive)

You can view the *exact* final headers sent via **View → Show Postman Console**.

### Common Custom Headers You'll Add

| Header | Typical value | Use case |
|---|---|---|
| `Authorization` | `Bearer <token>` | Auth (often auto-set via the Authorization tab instead) |
| `Content-Type` | `application/json` | Tell the server the body format |
| `Accept` | `application/json` | Tell the server what you want back |
| `X-Request-ID` | `{{$guid}}` | Tracing/correlation ID, often set via a dynamic variable |
| `X-API-Version` | `2023-10-01` | API versioning via header |

### Overriding Auto-Generated Headers
If you manually add a header that Postman would otherwise auto-generate (e.g., `Content-Type`), your manual value takes precedence — but Postman will show a small grey "this will be overridden/auto-generated" hint if there's a conflict with the Body tab's selection.

## Practice Exercise

1. Send `GET https://postman-echo.com/headers` with a custom header `X-Test-Header: hello-postman`.
2. Confirm it's echoed back in the response `headers` object.
3. Open the Postman Console and identify at least 3 headers Postman added automatically that you didn't type yourself.

Continue to → [2.3 Request Body Types](03-request-body-types.md)

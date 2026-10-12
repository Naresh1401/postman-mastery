# 2.4 Response Handling

## The Response Viewer

After clicking **Send**, the bottom/right panel shows:

- **Status** — e.g., `200 OK` (green = 2xx, orange = 3xx/4xx, red = 5xx/error)
- **Time** — total round-trip time in ms. Click it to expand a **timing breakdown**: Socket Initiated → DNS Lookup → TCP Handshake → TLS Handshake → Request Sent → Waiting (TTFB) → Content Download.
- **Size** — response body + headers size.

## Body Tab Views

| View | What it shows |
|---|---|
| **Pretty** | Formatted/indented, syntax-highlighted (JSON/XML/HTML/JS auto-detected) |
| **Raw** | Exact bytes as received, no formatting |
| **Preview** | Renders HTML responses as an actual webpage (sandboxed iframe) — useful when an API returns HTML/email templates |
| **Visualize** | Custom-rendered view using a `pm.visualizer.set()` script (Module 05.5) — e.g., turn JSON into a chart or table |

## Headers Tab
Lists all response headers — check `Content-Type`, caching headers, rate-limit headers (`X-RateLimit-Remaining`, etc.) here.

## Cookies Tab
Shows cookies the response tried to set via `Set-Cookie`. Postman maintains a **cookie jar** per domain, shared across requests in the same client (similar to a browser) — see **Cookies** manager (bottom of request builder, or Settings → Cookies).

## Test Results Tab
Shows pass/fail for every `pm.test()` block in your **Tests** script, with a running count (`3/3 passed`). This is where automated assertions live — fully covered in [Module 05.2](../05-scripting/02-test-scripts-and-assertions.md).

## Saving / Reusing Responses

- **Save Response** — click the dropdown next to Send → "Save Response" to pin an example response to the request. Saved examples:
  - Show up under the request in the sidebar (handy as living documentation).
  - Can be used directly to power a **Mock Server** (Module 08).
- **Compare** — Postman can diff two saved responses side-by-side (useful for regression checking after an API change).

## Response Size/Time Warnings

Postman will warn and may truncate rendering of very large responses (default soft cap around tens of MB) to keep the UI responsive. For huge payloads, use **Raw** view or save and inspect externally.

## Downloading a Response Body

Click **Save Response → Save to a file** to export the raw body (e.g., downloading a generated PDF/image returned by an endpoint).

## Practice Exercise

1. `GET https://postman-echo.com/stream/5` — observe a streamed, newline-delimited JSON response.
2. `GET https://postman-echo.com/delay/3` — observe the timing breakdown showing ~3s waiting time.
3. `GET https://postman-echo.com/cookies/set?testCookie=hello` then `GET https://postman-echo.com/cookies` — observe the cookie persisting across requests via Postman's cookie jar.

Continue to → [2.5 Cookies and Sessions](05-cookies-and-sessions.md)

# 2.5 Cookies and Sessions

## How Postman Handles Cookies

Postman maintains a built-in **cookie jar**, scoped per domain, that behaves like a browser:
1. When a response includes `Set-Cookie`, Postman stores it automatically.
2. On subsequent requests to the same domain, Postman automatically attaches stored cookies via the `Cookie` header — you don't need to set this manually.

## Viewing and Managing Cookies

- Click **Cookies** link below the Send button (or **Settings → Cookies**) to open the **Cookie Manager**.
- Here you can view, add, edit, or delete cookies per domain — useful for manually injecting a session cookie copied from a browser's DevTools.

## Syncing Browser Cookies (Interceptor)

If an app's auth relies on cookies set during a browser login flow (common for session-based web apps), install the **Postman Interceptor** extension:
1. Install from the Chrome Web Store.
2. Enable it in Postman: **Settings → General → Request via Interceptor** (or capture mode).
3. Log in to the target site in Chrome as normal.
4. Postman can now read those session cookies for matching-domain requests.

## Domain Scoping Gotchas

- Cookies are strict about **domain** and **path** — a cookie set for `api.example.com` won't automatically apply to `example.com` or `sub.api.example.com` unless the server explicitly set `Domain=.example.com`.
- `Secure` cookies only get sent over HTTPS.
- `HttpOnly` cookies are hidden from JavaScript (irrelevant to Postman's native cookie jar, since Postman isn't a browser's JS sandbox — it can still read/use them).

## Disabling the Cookie Jar for a Request

Per-request **Settings tab** → toggle "Send cookies" / "Automatically follow redirects" — useful when testing how an API behaves for a brand-new, cookie-less client.

## Session-Based Auth Flow Example

```
1. POST /login  { "username": "...", "password": "..." }
   → Response: Set-Cookie: sessionId=abc123; HttpOnly; Secure

2. GET /profile
   → Postman automatically attaches: Cookie: sessionId=abc123
   → Response: 200 OK with profile data
```

No scripting needed for this — it "just works" because of the shared cookie jar, as long as both requests hit the same domain in the same Postman session.

## Clearing Cookies

Cookie Manager → select domain → **Delete** (or **Clear All**) — important before testing a fresh "logged out" state.

## Practice Exercise

1. `GET https://postman-echo.com/cookies/set?session=abc123`
2. Open Cookie Manager, confirm `session=abc123` is stored for `postman-echo.com`.
3. `GET https://postman-echo.com/cookies` and confirm the cookie is echoed back automatically, without you setting any header.
4. Delete the cookie via Cookie Manager and repeat step 3 — confirm it's now empty.

---
This completes Module 02. Continue to → [Module 03: Variables & Environments](../03-variables-and-environments/01-variable-scopes.md)

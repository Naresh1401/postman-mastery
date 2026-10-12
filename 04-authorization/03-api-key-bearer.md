# 4.3 API Key and Bearer Token

## API Key Authentication

**How it works**: the server issues a static key; the client sends it on every request, either as:
- A **header** (e.g., `X-API-Key: abc123`), or
- A **query parameter** (e.g., `?api_key=abc123`)

**In Postman**:
1. Authorization tab → Type: **API Key**.
2. Fill in:
   - **Key**: the header/param name (e.g., `X-API-Key`)
   - **Value**: `{{apiKey}}` (reference an environment variable, don't hardcode)
   - **Add to**: `Header` or `Query Params` dropdown.

```
GET https://api.example.com/data
X-API-Key: {{apiKey}}
```

### When to Use Header vs Query Param
- **Header** (preferred): keeps the key out of URLs, browser history, server access logs, and shared/bookmarked links.
- **Query Param**: sometimes required by APIs that don't support header-based keys (e.g., some public data APIs) — be aware these **do** show up in logs.

## Bearer Token Authentication

**How it works**: sends a token (often a JWT, OAuth access token, or PAT) via:
```
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

**In Postman**:
1. Authorization tab → Type: **Bearer Token**.
2. Token field: `{{accessToken}}` (never hardcode a real token into the Initial Value).

### Where Does `{{accessToken}}` Come From?

Typically one of:
1. **Manually pasted** after logging in elsewhere (quick/manual workflows).
2. **Captured via a script** — a "login" request's **Tests** script extracts the token from the response and stores it:
```js
// In the Tests tab of a "Login" request
const response = pm.response.json();
pm.environment.set("accessToken", response.token);
```
3. **Fully automated via OAuth 2.0** flow (see [4.4](04-oauth1-oauth2.md)) — Postman requests and refreshes the token for you.

## Understanding a JWT (JSON Web Token)

A JWT has 3 Base64Url-encoded parts separated by dots: `header.payload.signature`
```
eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkFkYSJ9.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c
```
- **Header**: algorithm/type metadata.
- **Payload**: claims — e.g., `sub` (subject/user id), `exp` (expiry, Unix timestamp), `iat` (issued-at), custom claims (roles, etc.).
- **Signature**: verifies the token wasn't tampered with (only the issuing server can produce a valid one with its secret/private key).

Postman doesn't decode JWTs natively in the Authorization UI, but you can decode one in a script for debugging:
```js
function decodeJwtPayload(token) {
    const payload = token.split('.')[1];
    const decoded = atob(payload.replace(/-/g, '+').replace(/_/g, '/'));
    return JSON.parse(decoded);
}
console.log(decodeJwtPayload(pm.environment.get("accessToken")));
```

## Practice Exercise

1. `GET https://postman-echo.com/bearer` with Authorization type Bearer Token, value `{{anyToken}}` where `anyToken` = `abc123` — confirm the response echoes `{"authenticated": true}`.
2. Create a `Login` request against `https://postman-echo.com/post` sending `{"username":"test"}`, then in its **Tests** tab, extract a fake value from the echoed response and store it as `pm.environment.set("accessToken", ...)`. Confirm the next request can use `{{accessToken}}`.

Continue to → [4.4 OAuth 1.0 and OAuth 2.0](04-oauth1-oauth2.md)

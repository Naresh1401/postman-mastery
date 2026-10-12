# 4.4 OAuth 1.0 and OAuth 2.0

## OAuth 1.0 (Legacy)

Used by some older APIs (classic Twitter API, some enterprise systems). Every request is cryptographically **signed** using a combination of:
- Consumer Key / Consumer Secret
- Token / Token Secret
- A signature method (usually `HMAC-SHA1`)
- A timestamp + nonce (to prevent replay attacks)

**In Postman**:
1. Authorization tab → Type: **OAuth 1.0**.
2. Fill in Consumer Key, Consumer Secret, Access Token, Token Secret, Signature Method.
3. Choose where the signed params go: **Header** (recommended) or **Query Params**.
4. Postman computes the signature and adds the `Authorization: OAuth oauth_consumer_key="...", oauth_signature="...", ...` header automatically on send.

You rarely need to hand-build this — just supply the 4 credential values and let Postman sign the request.

## OAuth 2.0 (Modern Standard)

The authorization type you'll use constantly with modern SaaS/enterprise APIs (Google, GitHub, Microsoft, Salesforce, etc.).

### Core Concepts
- **Authorization Server** — issues tokens (e.g., `accounts.google.com`).
- **Resource Server** — the actual API you're calling, which validates the token.
- **Access Token** — short-lived credential sent with each API request.
- **Refresh Token** — long-lived credential used to get a new access token without re-authenticating the user.
- **Scopes** — permissions requested (e.g., `read:user`, `repo`).

### Grant Types Postman Supports

| Grant Type | When to use |
|---|---|
| **Authorization Code** | Standard for apps with a login/consent screen (most common, most secure) |
| **Authorization Code (with PKCE)** | Same as above, plus protection against interception — recommended for public/native clients |
| **Implicit** | Legacy, discouraged now (token returned directly in URL fragment) |
| **Client Credentials** | Machine-to-machine (no user involved) — service calling another service |
| **Password Credentials** | Legacy, trades username/password directly for a token — avoid if possible |

### Setting Up OAuth 2.0 in Postman (Authorization Code Example)

1. Authorization tab → Type: **OAuth 2.0**.
2. Click **"Get New Access Token"**.
3. Fill in the dialog:
   - **Grant Type**: Authorization Code
   - **Callback URL**: `https://oauth.pstmn.io/v1/callback` (Postman's hosted redirect handler — works without you running your own redirect server) or your own registered redirect URI
   - **Auth URL**: the provider's authorization endpoint (e.g., `https://accounts.google.com/o/oauth2/v2/auth`)
   - **Access Token URL**: the provider's token endpoint
   - **Client ID** / **Client Secret**: from your registered OAuth app
   - **Scope**: space-separated list of permissions
   - **State**: optional random string for CSRF protection
4. Click **"Get New Access Token"** — Postman opens a browser popup, you log in/consent, and Postman captures the resulting token automatically.
5. Click **"Use Token"** to attach it to the current request.

### Token Management

- Postman stores retrieved tokens under **Manage Tokens** (link at the bottom of the OAuth 2.0 config) — you can view, refresh, or delete them.
- **Auto-refresh**: enable "Automatically refresh this token when expired" so Postman silently fetches a new access token using the refresh token when a request gets a 401, instead of failing.
- Tokens can be stored as a **collection/environment variable** automatically (configure "Token Name" + check "Store token in variable") so scripts/other requests can reference `{{accessToken}}` directly.

### Client Credentials Example (Machine-to-Machine)

```
Grant Type: Client Credentials
Access Token URL: https://auth.example.com/oauth/token
Client ID: {{clientId}}
Client Secret: {{clientSecret}}
Scope: read:data
Client Authentication: Send as Basic Auth header (or Send client credentials in body, per provider requirements)
```
No browser popup needed — Postman calls the token endpoint directly server-to-server.

## Practice Exercise (Conceptual — requires your own OAuth app)

1. Register a free OAuth app with GitHub (Developer Settings → OAuth Apps).
2. Set Callback URL to `https://oauth.pstmn.io/v1/callback`.
3. In Postman, configure OAuth 2.0 → Authorization Code with GitHub's auth/token URLs, your Client ID/Secret, scope `read:user`.
4. Get a new access token, use it to call `GET https://api.github.com/user` with the Bearer token Postman attaches.

Continue to → [4.5 AWS Signature, Hawk, and Custom Auth](05-aws-hawk-custom.md)

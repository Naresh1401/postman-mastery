# 4.2 Basic Auth, Digest Auth, and NTLM

## Basic Authentication

**How it works**: username and password are concatenated as `username:password`, Base64-encoded, and sent as:
```
Authorization: Basic dXNlcjpwYXNzd29yZA==
```

**In Postman**:
1. Authorization tab → Type: **Basic Auth**.
2. Enter Username and Password (use `{{variables}}`, never hardcode).
3. Postman encodes and sets the header automatically on send.

⚠️ Basic Auth sends credentials in an easily-reversible encoding (not encryption) — **always use over HTTPS only**. Never send Basic Auth over plain HTTP.

### Practice
```
GET https://postman-echo.com/basic-auth
Authorization: Basic Auth, username=postman, password=password
```
`postman-echo.com/basic-auth` is a public test endpoint that accepts exactly `postman`/`password` — confirm you get `{"authenticated": true}`.

## Digest Authentication

**How it works**: more secure than Basic — the client and server exchange a *challenge* (nonce), and the client hashes credentials + nonce (typically MD5/SHA) instead of sending them in a reversible form.

**Flow**:
1. Client sends request with no credentials.
2. Server responds `401` with a `WWW-Authenticate: Digest realm="...", nonce="..."` header.
3. Postman automatically re-sends the request with a computed `Authorization: Digest username="...", realm="...", nonce="...", response="<hash>"` header.

**In Postman**:
1. Authorization tab → Type: **Digest Auth**.
2. Enter Username/Password — Postman handles the challenge/response handshake automatically (you'll see 2 requests in the Console: the initial 401 challenge, then the authenticated retry).

### Practice
```
GET https://postman-echo.com/digest-auth
Authorization: Digest Auth, username=postman, password=password
```

## NTLM / Negotiate Authentication

**What it is**: a Windows-native challenge-response auth protocol, common for internal enterprise APIs/intranets (e.g., IIS servers using Windows Integrated Authentication).

**In Postman**:
1. Authorization tab → Type: **NTLM Authentication**.
2. Provide Username, Password, and optionally Domain.
3. Postman performs the multi-step NTLM handshake automatically (Type 1 negotiate → Type 2 challenge → Type 3 authenticate).

> NTLM support requires the **Desktop app** (not reliably available via Postman Web) since it needs native networking capabilities.

## Comparison Table

| | Basic | Digest | NTLM |
|---|---|---|---|
| Credentials sent as | Base64 (reversible) | Hashed challenge-response | Hashed challenge-response (multi-step) |
| Requires HTTPS to be safe | Yes, strictly | Recommended, less critical than Basic | Recommended |
| Common use case | Simple internal tools, quick prototypes | Slightly hardened legacy APIs | Windows/enterprise intranet services |
| Setup complexity in Postman | Trivial | Trivial (Postman handles handshake) | Trivial (Postman handles handshake) |

Continue to → [4.3 API Key and Bearer Token](03-api-key-bearer.md)

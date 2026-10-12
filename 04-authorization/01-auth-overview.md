# 4.1 Authorization Overview

## Where Authorization Lives in Postman

Every request has an **Authorization** tab, separate from Headers (though under the hood, most auth types just set an `Authorization` header or query param for you). Using the Authorization tab instead of manually typing headers has key benefits:
- Postman generates the correct header format/encoding for you (e.g., Base64-encoding Basic Auth credentials).
- Secrets can stay in variables, with the Authorization tab just referencing them.
- Auth can be set **once at the Collection or Folder level** and inherited by every request inside it.

## Inheritance Model

```
Collection (sets auth, e.g., Bearer Token with {{accessToken}})
  └── Folder (can override, or "Inherit auth from parent")
        └── Request (can override, or "Inherit auth from parent")
```

Set auth at the **Collection** level whenever every/most requests need the same credentials — then individual requests just select **"Inherit auth from parent"** (the default for new requests) and you only maintain the token/credentials in one place.

## Supported Authorization Types

| Type | Common use case | Covered in |
|---|---|---|
| No Auth | Public endpoints | — |
| Basic Auth | Simple username/password APIs, legacy systems | [4.2](02-basic-digest-ntlm.md) |
| Digest Auth | More secure than Basic, hashes credentials | [4.2](02-basic-digest-ntlm.md) |
| NTLM / Negotiate | Windows/enterprise intranet APIs | [4.2](02-basic-digest-ntlm.md) |
| API Key | Simple token in header or query param | [4.3](03-api-key-bearer.md) |
| Bearer Token | JWT/OAuth access tokens | [4.3](03-api-key-bearer.md) |
| OAuth 1.0 | Legacy signed-request APIs (older Twitter API, etc.) | [4.4](04-oauth1-oauth2.md) |
| OAuth 2.0 | Modern standard (Google, GitHub, most SaaS APIs) | [4.4](04-oauth1-oauth2.md) |
| AWS Signature | AWS service APIs (S3, API Gateway, etc.) | [4.5](05-aws-hawk-custom.md) |
| Hawk Authentication | HMAC-based auth scheme, less common | [4.5](05-aws-hawk-custom.md) |
| Akamai EdgeGrid | Akamai APIs specifically | [4.5](05-aws-hawk-custom.md) |
| ASAP (Atlassian) | Atlassian internal service auth | [4.5](05-aws-hawk-custom.md) |

## How to Verify What's Actually Being Sent

Regardless of auth type selected, always confirm via **Postman Console** (`Cmd/Ctrl+Alt+C`) what the *actual* outgoing `Authorization` header (or query param) looked like — this is the fastest way to debug "why am I getting a 401."

## The #1 Debugging Checklist for Auth Failures

1. **401 vs 403** — 401 means your credentials weren't accepted/recognized at all; 403 means they were recognized but lack permission.
2. Check **token expiry** — JWTs/OAuth tokens expire; decode at https://jwt.io (paste only in a safe/offline context for sensitive tokens) to inspect `exp`.
3. Check you're hitting the right **environment's** token (Dev token won't work against Prod).
4. Check for **leading/trailing whitespace** in a pasted token (very common copy-paste bug).
5. Confirm the **auth type matches what the server expects** — sending Basic Auth to an endpoint expecting Bearer will fail even with "correct" credentials in the wrong format.

Continue to → [4.2 Basic, Digest & NTLM](02-basic-digest-ntlm.md)

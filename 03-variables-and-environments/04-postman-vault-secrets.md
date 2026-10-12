# 3.4 Postman Vault & Secrets

## The Problem It Solves

Storing API keys/tokens directly in an Environment's "Initial Value" means they get **saved into the collection/environment JSON**, which can be:
- Synced to Postman Cloud
- Shared with a team workspace
- Exported and accidentally committed to Git

**Postman Vault** (newer desktop-app feature) gives you a way to reference secrets that **never leave your machine** and are never part of any synced/exported JSON.

## How Vault Works

1. Open the **Vault** panel (padlock icon in the sidebar / bottom status bar).
2. Add a secret: a key name (e.g., `vault:apiKey`) and its real value.
3. Reference it in any request using the `{{vault:apiKey}}` syntax — functions exactly like a normal variable at send-time, but:
   - The actual value is stored in your **local OS-encrypted storage**, not in Postman's cloud or the collection file.
   - It is **never exported** when you export a collection/environment.
   - Vault is **disabled by default** when using Postman via a browser/web context without the desktop agent, since it depends on local secure storage.

## Vault vs Environment "secret" Type vs Current Value

| Mechanism | Synced to cloud? | Exported in JSON? | Best for |
|---|---|---|---|
| Environment variable, type=`default`, Initial Value | Yes | Yes | Non-sensitive shared config (base URLs) |
| Environment variable, type=`secret`, Initial Value | Yes (value still stored, just masked in UI) | Yes (masked in UI but present in data unless you strip it) | Not a substitute for real secret management — just UI masking |
| Environment variable, **Current Value only** (never saved to Initial) | No (Current Value isn't synced) | No | Personal, machine-local secrets without using Vault |
| **Postman Vault** | No | No | True secrets: real API keys, personal access tokens |

> 🔑 Rule: if a value should **never** appear in a `git diff` of an exported collection or in a teammate's synced copy, it belongs in **Vault** or in a **Current Value**-only field — never in "Initial Value."

## Practical Example

```
# In a request's Authorization tab:
Type: Bearer Token
Token: {{vault:githubToken}}
```
Even if you export this collection and send it to a teammate, `{{vault:githubToken}}` stays as literal text — each person must populate their *own* local Vault entry for it to resolve.

## Using Secrets Safely in Scripts

```js
// BAD: hardcoding a secret directly in a script (gets saved/exported with the collection)
const token = "sk_live_abc123...";

// GOOD: read from vault-backed variable
const token = pm.variables.get("vault:apiKey");
```

## Team Secret Management Alternatives

For team workspaces, Postman also supports:
- **Environment variable encryption at rest** on Postman's servers (baseline protection, but still technically shared with team members who can view the environment).
- Integration with external secret managers (via pre-request scripts calling out to your own secrets API, though this adds complexity/latency).
- **Role-based access control** on team workspaces to limit who can view/edit environments containing sensitive defaults.

## Checklist Before Sharing/Exporting a Collection

- [ ] No real tokens/passwords in any request's Authorization tab (use variables instead).
- [ ] No secrets in Collection/Environment "Initial Value" fields.
- [ ] Sensitive values moved to Vault or Current-Value-only.
- [ ] Reviewed pre-request/test scripts for any hardcoded credentials.
- [ ] `.postman_environment.json` files intended for git should be "sanitized" exports with empty/placeholder values for secrets.

---
This completes Module 03. Continue to → [Module 04: Authorization](../04-authorization/01-auth-overview.md)

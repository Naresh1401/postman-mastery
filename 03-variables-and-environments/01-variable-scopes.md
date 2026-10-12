# 3.1 Variable Scopes

Variables are what make Postman scale beyond a single hardcoded request. A variable is written `{{variableName}}` and can be used in the URL, headers, body, params, and scripts.

## The Scope Hierarchy (Highest → Lowest Precedence)

When the same variable name exists in multiple scopes, Postman resolves it using this precedence order (most specific wins):

1. **Local** — scoped to a single script execution (`pm.variables`), never persisted, disappears when the request finishes.
2. **Data** — comes from a CSV/JSON file during a Collection Runner/Newman iteration (Module 07.2).
3. **Environment** — the currently *active* environment's variables.
4. **Collection** — variables defined at the collection level, available to every request within it regardless of active environment.
5. **Global** — available across *all* collections and environments in the workspace; lowest precedence (easily overridden, use sparingly).

> 🔑 Rule of thumb: **Global = emergency/temporary only. Collection = shared defaults. Environment = per-stage config (Dev/Stage/Prod). Data = per-iteration test data. Local = scratch space inside one script.**

## Where Each Scope Lives in the UI

| Scope | Managed from |
|---|---|
| Global | Sidebar → Environments → "Globals" (always listed) |
| Collection | Right-click Collection → Edit → **Variables** tab |
| Environment | Sidebar → Environments → select one → **Variables** tab |
| Data | Not in UI — comes from the file selected when running the Collection Runner |
| Local | Only set/read via scripts: `pm.variables.set("x", 1)` |

## Defining a Variable

In the Collection/Environment **Variables** tab, each row has:
- **Variable** — the name (no braces)
- **Type** — `default` or `secret` (secret masks the value in the UI, e.g., API keys)
- **Initial Value** — committed/shared value (exported with the collection — be careful with secrets here!)
- **Current Value** — the value actually used at runtime, *not* exported when you share/export the collection — this is where real secrets should live locally.

> ⚠️ **Security note**: "Initial Value" gets saved into the collection JSON and can be shared/synced/committed. Never put real secrets there. Use "Current Value" (or better, [Postman Vault](04-postman-vault-secrets.md)) for anything sensitive.

## Reading and Writing Variables via Scripts

```js
// Set
pm.globals.set("token", "abc123");
pm.environment.set("userId", 42);
pm.collectionVariables.set("baseUrl", "https://api.example.com");
pm.variables.set("tempFlag", true); // local, script-scoped only

// Get
let token = pm.environment.get("token");

// Get the "effective" value regardless of scope (follows precedence)
let effective = pm.variables.get("userId");

// Remove
pm.environment.unset("token");

// Clear all in a scope
pm.environment.clear();
```

## Using Variables in the UI

Anywhere you see a text field (URL, headers, body, params), type `{{` and Postman will autocomplete matching variable names, color-coded:
- 🟠 **Orange** = variable is undefined in any active scope (will send literally as `{{foo}}` — a common bug source!)
- 🟢 **Green/grey** (with tooltip showing resolved value) = variable resolves successfully. Hover any `{{variable}}` to see its current resolved value and which scope it came from.

## Common Pitfall: "It worked in one environment but not another"

This is almost always a scope precedence issue — e.g., a Collection variable sets a default `baseUrl`, but someone also defined `baseUrl` in the active Environment with a stale value, which wins because Environment > Collection. **Use the hover-tooltip to check which scope is actually supplying the value.**

Continue to → [3.2 Environments](02-environments.md)

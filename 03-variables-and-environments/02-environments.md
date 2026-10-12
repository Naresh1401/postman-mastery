# 3.2 Environments

## What an Environment Is

An **Environment** is a named, switchable set of variables — typically one per deployment stage:
- `Dev` → `baseUrl = https://dev-api.example.com`
- `Staging` → `baseUrl = https://staging-api.example.com`
- `Prod` → `baseUrl = https://api.example.com`

Your **requests stay identical** (`{{baseUrl}}/users`) — only the active environment changes which actual URL/token/credentials get used. This is the single biggest productivity unlock in Postman: write once, run against any stage.

## Creating an Environment

1. Sidebar → **Environments** → **+** (Create Environment).
2. Name it (e.g., `Dev`).
3. Add variables: `baseUrl`, `apiKey`, `userId`, etc., with Initial/Current values.
4. Save.

## Switching the Active Environment

Top-right corner of the request builder has an **environment dropdown** — select which environment is "active." Only one environment is active per workspace tab at a time. All `{{variable}}` references resolve against whichever environment is currently selected (plus collection/global fallbacks).

## Environment Quick Look

Click the **eye icon** next to the environment dropdown to see all variables in the active environment and their current resolved values, without leaving your current tab.

## Duplicating an Environment

Right-click an environment → **Duplicate** — fast way to create `Staging` from an existing `Dev` environment, then just change the values that differ.

## Exporting / Importing Environments

- **Export**: right-click environment → Export → saves a `.postman_environment.json` file.
- **Import**: File → Import → select the `.json` file.
- Useful for sharing a baseline environment with teammates or committing a *redacted* version (no real secrets) to a Git repo for onboarding (see [12-hands-on-project](../12-hands-on-project/)).

## Environment-as-Code Example

```json
{
  "id": "e1a2b3c4-dev",
  "name": "Dev",
  "values": [
    { "key": "baseUrl", "value": "https://postman-echo.com", "type": "default", "enabled": true },
    { "key": "apiKey", "value": "", "type": "secret", "enabled": true }
  ],
  "_postman_variable_scope": "environment"
}
```

## No-Environment Mode

You can work with **"No Environment"** selected and rely purely on Collection/Global variables — fine for small/simple collections, but as soon as you need Dev vs Prod switching, you need real Environments.

## Best Practices

1. **Never hardcode a URL or token** in a request once you have 2+ requests reusing it — extract to a variable immediately.
2. **Name variables consistently** across environments (`baseUrl`, not `baseURL` in one and `base_url` in another) — case and format matter, they are different variables otherwise.
3. **Keep secrets out of "Initial Value"** — see [3.4 Postman Vault & Secrets](04-postman-vault-secrets.md).
4. **One environment per deployment stage**, not per developer — avoid "John's Dev Environment" sprawl; use personal **Current Value** overrides instead (these aren't synced/shared even in a team workspace, only Initial Values are shared by default).

## Practice Exercise

1. Create two environments: `Dev` (`baseUrl=https://postman-echo.com`) and `Fake-Prod` (`baseUrl=https://jsonplaceholder.typicode.com`).
2. Create a request `GET {{baseUrl}}/get` (works vs postman-echo) — notice it would need a different path for the other API, which is a good lesson: variables cover config differences, not structurally different APIs.
3. Build a single request `GET {{baseUrl}}/get` and switch between `Dev` and `Fake-Prod` to see it hit different hosts without editing the request itself (you'll get a 404 against jsonplaceholder since the path differs — that's expected and illustrates the point).

Continue to → [3.3 Dynamic Variables](03-dynamic-variables.md)

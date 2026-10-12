# 6.4 Best Practices and Naming Conventions

## Naming Conventions

| Item | Convention | Example |
|---|---|---|
| Collection | `<System/Service> - <Purpose>` | `Payments API - Regression Suite` |
| Folder | Resource/feature name, Title Case | `Users`, `Orders`, `Auth` |
| Request | `<Verb phrase>`, consistent tense | `Create User`, `Get User by ID`, `Delete Order` (not a mix of `getUser`, `DELETE_ORDER`, `update-user`) |
| Environment | Deployment stage, capitalized | `Dev`, `Staging`, `Prod` — not `john-local`, `test2` |
| Variable | `camelCase`, consistent across environments | `baseUrl`, `accessToken`, `userId` — never `base_url` in one place and `baseURL` in another |

## Structural Best Practices

1. **One collection per service/API**, not one giant collection for your entire company's API surface — keeps run times and documentation scoped and relevant.
2. **Mirror your API's resource structure** in folders — makes the collection navigable by anyone who knows the API, even without reading every request.
3. **Numbered prefixes for sequential/dependent flows**: `1. Login`, `2. Create Order`, `3. Verify Order` — makes execution order self-documenting, critical for Collection Runner/Newman runs that depend on chaining (Module 05.4).
4. **Separate "setup/teardown" requests** explicitly (e.g., a `0. Reset Test Data` request at the top of a folder) rather than relying on hidden side effects.

## Script Hygiene

1. **Keep collection/folder-level scripts minimal and generic** — things every request needs (e.g., a global response-time assertion, a global auth-refresh check). Put *specific* assertions at the request level.
2. **Fail fast and descriptively** — a failing `pm.test()` should have a name that tells you *exactly* what broke without opening the script:
   ```js
   // Bad
   pm.test("test1", () => pm.expect(res.id).to.exist);
   // Good
   pm.test("Created order response includes a valid order ID", () => pm.expect(res.id).to.exist);
   ```
3. **Avoid duplicated logic** — if 5 requests need the same token-refresh check, put it once at the collection/folder level, not copy-pasted 5 times.
4. **Comment non-obvious script logic** — especially custom auth signing, polling loops, or conditional `setNextRequest` branches.

## Variable Hygiene

1. **Never commit real secrets** to "Initial Value" fields that get exported/synced (see [3.4](../03-variables-and-environments/04-postman-vault-secrets.md)).
2. **Clean up variables you set** during a run (`pm.environment.unset(...)`) if they could leak stale state into unrelated future runs.
3. **Document non-obvious variables** in the collection description — "requires `apiKey` to be set in the active environment before running."

## Environment Management

1. One environment per **stage**, not per developer.
2. Keep environment **names and variable keys identical across stages** — only values should differ — so switching environments never breaks a request due to a missing/renamed variable.
3. Export a **sanitized template environment** (`dev.postman_environment.json` with placeholder values) for onboarding new team members or committing to Git.

## Collaboration Etiquette (Team Workspaces)

1. **Don't edit shared/production collections directly** — fork, change, open a Postman "pull request" for review (Module 10).
2. **Use comments** on requests/collections for async discussion instead of Slack threads that get lost.
3. **Tag/label collections** (if your plan supports it) to distinguish `stable`, `experimental`, `deprecated`.

## A Quick "Is This Collection Healthy?" Checklist

- [ ] Every request is named clearly and consistently.
- [ ] No hardcoded URLs/tokens anywhere — all via variables.
- [ ] At least one test assertion per request (status code, minimum).
- [ ] Descriptions exist at the collection and (ideally) request level.
- [ ] Can a new team member run the whole collection successfully just by selecting the right environment, with zero manual edits?

---
This completes Module 06. Continue to → [Module 07: Running & Automation](../07-running-and-automation/01-collection-runner.md)

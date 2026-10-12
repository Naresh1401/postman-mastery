# 5.4 Chaining Requests

"Chaining" means **using data extracted from one request's response as input to a later request** — the backbone of any realistic end-to-end API test (e.g., create a resource → use its returned ID → fetch/update/delete it).

## The Core Pattern

```
Request A (Tests tab)                 Request B (uses the value)
──────────────────────                ─────────────────────────
pm.environment.set(                   GET {{baseUrl}}/users/{{userId}}
  "userId",
  pm.response.json().id
);
```

## Full Worked Example: Create → Read → Update → Delete (CRUD Chain)

### Request 1: `POST {{baseUrl}}/users`
Body:
```json
{ "name": "{{$randomFullName}}", "email": "{{$randomEmail}}" }
```
Tests:
```js
pm.test("User created", function () {
    pm.response.to.have.status(201);
});
const json = pm.response.json();
pm.collectionVariables.set("userId", json.id);
pm.collectionVariables.set("createdUserName", json.name);
```

### Request 2: `GET {{baseUrl}}/users/{{userId}}`
Tests:
```js
pm.test("Fetched user matches created user", function () {
    const json = pm.response.json();
    pm.expect(json.name).to.eql(pm.collectionVariables.get("createdUserName"));
});
```

### Request 3: `PUT {{baseUrl}}/users/{{userId}}`
Body:
```json
{ "name": "{{createdUserName}} (Updated)" }
```

### Request 4: `DELETE {{baseUrl}}/users/{{userId}}`
Tests:
```js
pm.test("User deleted", function () {
    pm.response.to.have.status(204);
});
pm.collectionVariables.unset("userId"); // cleanup
```

> Running these 4 requests **in order** (manually, or via Collection Runner/Newman) performs a full lifecycle test with zero hardcoded IDs — each step depends dynamically on the previous one's real response.

## Controlling Execution Order Programmatically

By default, Collection Runner/Newman executes requests **top-to-bottom** in the order they appear in the collection/folder. You can override this for conditional branching:

```js
// In a Tests script
if (pm.response.json().status === "pending") {
    pm.execution.setNextRequest("Poll Status"); // loop back to re-check
} else {
    pm.execution.setNextRequest("Finalize Order"); // move on
}
```

> ⚠️ `setNextRequest` only affects **Collection Runner / Newman** execution order — it has no effect when you manually click "Send" on individual requests in the builder.

## Polling Pattern (Wait for Async Processing)

Some APIs process things asynchronously (e.g., a video transcoding job). A chaining pattern to poll until done:

```js
// Tests script on a "Check Job Status" request
const json = pm.response.json();
if (json.status !== "complete") {
    pm.execution.setNextRequest("Check Job Status"); // re-run itself
} else {
    pm.collectionVariables.set("resultUrl", json.resultUrl);
    pm.execution.setNextRequest("Download Result");
}
```
Combine with a short `setTimeout`-like delay via the collection's run settings (Delay between requests) to avoid hammering the server while polling.

## Chaining Across Folders/Collections

- Within the **same collection**: use Collection Variables — always visible to every request in that collection.
- Across **different collections**: use Environment or Global variables (since Collection Variables are scoped to just their own collection), or use the **Postman API** to pull data programmatically between runs.

## Common Pitfalls

1. **Forgetting to clean up variables** between test runs — a stale `userId` from a previous failed run can make the next run pass/fail misleadingly. Add cleanup logic (`unset`) in Tests, or reset variables in a dedicated "Setup" request at the top of the collection.
2. **Race conditions in parallel runs** — if the same collection runs concurrently (e.g., two CI jobs at once) and both write to the same **Environment** (not Collection) variable, they can clobber each other. Prefer **Collection Variables** or **Data files** per run for isolation, or use unique per-iteration values (`{{$guid}}`) to avoid collisions entirely.
3. **Assuming order without verifying** — always name requests clearly (`1. Create User`, `2. Get User`, ...) or rely on explicit `setNextRequest` chains rather than assuming folder order is obvious to future readers.

Continue to → [5.5 Visualizer](05-visualizer.md)

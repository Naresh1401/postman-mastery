# 8.1 Mock Servers

## What a Mock Server Is

A **Mock Server** is a Postman-hosted fake backend that returns pre-defined example responses for requests matching a collection's structure — **without any real backend existing**. It's generated directly from the saved requests and example responses already in your collection.

## Why Use One

1. **Frontend/backend parallel development** — frontend team builds against the mock while backend is still being implemented, based on an agreed-upon API contract.
2. **Demoing** — show a working-looking app/integration before the real API is finished.
3. **Testing error paths** — simulate a `500` or `429` response that might be hard to trigger reliably against a real backend.
4. **Removing external dependencies in automated tests** — avoid hitting a real (rate-limited, slow, or flaky) third-party API in every CI run; mock its shape instead.

## Creating a Mock Server

1. Make sure your collection has at least one request with a **saved example response** (Save Response → "Save as Example").
2. Sidebar → **Mock Servers** → **Create New Mock Server** (or right-click a collection → **Mock Collection**).
3. Choose:
   - The **Collection** to base it on
   - An **Environment** (optional) to auto-create, with a `{{baseUrl}}`-equivalent variable pointing at the mock's URL
   - Whether it's **Private** (requires an API key to call) or **Public**
4. Postman provisions a unique URL like:
   ```
   https://a1b2c3d4-e5f6-7890-abcd-ef1234567890.mock.pstmn.io
   ```
5. Any request sent to that URL matching a saved example's method+path returns that **exact saved example response** (status, headers, body).

## Matching Logic

Mock Servers match incoming requests to saved examples by:
1. **Method** (GET/POST/etc.) — must match exactly.
2. **Path** — must match (path variables like `/users/:id` match any value in that segment).
3. If multiple examples exist for the same method+path (e.g., a success and a 404 example), Postman matches based on **query params or request body** if you've set them up distinctly per example, or you can force a specific example via the `x-mock-response-name` or `x-mock-response-id` header.

## Example Setup

### Request: `GET /users/:id`
- **Example 1** — "Success": response `200` with a sample user JSON.
- **Example 2** — "Not Found": response `404` with `{"error": "User not found"}`.

### Forcing a Specific Example When Calling the Mock
```
GET https://<mock-id>.mock.pstmn.io/users/42
x-mock-response-name: Not Found
```
This lets you deterministically test both the happy path and the error path against the same mock endpoint.

## Dynamic Mock Responses

Saved examples are mostly static, but you can combine dynamic variables inside them:
```json
{ "id": "{{$randomInt}}", "requestedAt": "{{$isoTimestamp}}" }
```
Postman resolves these at **mock response time**, not just when you originally saved the example — so repeated calls return fresh values for those fields.

## Mock Server Call Logs

Sidebar → Mock Servers → select one → **Call Logs** shows every request the mock received, including ones that **didn't match** any example (helpful for debugging "why is my mock returning a generic 404" — often it's a path typo or unmatched method).

## Limitations

- Mock Servers return **static or lightly-templated** data — they don't run real backend logic (no actual database, no real business rules beyond what dynamic variables can fake).
- Rate limits apply on free plans for mock server call volume.

## Practice Exercise

1. Add a saved example "Success" (200, some JSON user object) and "Not Found" (404) to a `Get User` request in your practice collection.
2. Create a Mock Server from this collection.
3. Call the mock's URL for `GET /users/1` and confirm you get the "Success" example back.
4. Call it again with header `x-mock-response-name: Not Found` and confirm you get the 404 example instead.

---
This completes Module 08. Continue to → [Module 09: Advanced Protocols](../09-advanced-protocols/01-graphql.md)

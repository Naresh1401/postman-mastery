# 3.3 Dynamic Variables

Postman ships a set of built-in **dynamic variables**, prefixed with `$`, that generate fresh fake/random data **every time a request is sent** — no scripting required. They're powered internally by the `faker.js` library.

## Why Use Them

- Avoid sending the exact same test data repeatedly (which can trip unique-constraint validations on APIs).
- Quickly generate realistic-looking fake data for demos/tests.
- Add correlation/trace IDs for debugging distributed requests.

## Commonly Used Dynamic Variables

| Variable | Produces |
|---|---|
| `{{$guid}}` | A random UUID v4, e.g. `3fa85f64-5717-4562-b3fc-2c963f66afa6` |
| `{{$timestamp}}` | Current Unix timestamp (seconds) |
| `{{$isoTimestamp}}` | Current time in ISO 8601 format |
| `{{$randomInt}}` | Random integer 0–1000 |
| `{{$randomUUID}}` | Alias for a random UUID |
| `{{$randomFirstName}}` / `{{$randomLastName}}` / `{{$randomFullName}}` | Fake names |
| `{{$randomEmail}}` | Fake email address |
| `{{$randomUserName}}` | Fake username |
| `{{$randomPassword}}` | Fake password string |
| `{{$randomPhoneNumber}}` | Fake phone number |
| `{{$randomCity}}` / `{{$randomCountry}}` / `{{$randomStreetAddress}}` | Fake address data |
| `{{$randomCompanyName}}` | Fake company name |
| `{{$randomJobTitle}}` | Fake job title |
| `{{$randomColor}}` | Random color name |
| `{{$randomPrice}}` | Random price value |
| `{{$randomBoolean}}` | `true`/`false` |
| `{{$randomIP}}` / `{{$randomIPV6}}` | Fake IP address |
| `{{$randomUrl}}` | Fake URL |
| `{{$randomLoremWord}}` / `{{$randomLoremSentence}}` / `{{$randomLoremParagraph}}` | Lorem ipsum text of varying length |

> Full list (100+): type `{{$` in any field and Postman's autocomplete will show every available dynamic variable with a live preview of its generated value.

## Example: Creating Unique Test Users

```json
{
  "username": "{{$randomUserName}}",
  "email": "{{$randomEmail}}",
  "requestId": "{{$guid}}",
  "createdAt": "{{$isoTimestamp}}"
}
```
Every send produces a brand-new, non-colliding payload — ideal for `POST /users` endpoints with unique-email constraints.

## Combining with Pre-request Scripts

If the built-in list doesn't cover your need, generate custom dynamic values in a **Pre-request Script** and store them as a variable:
```js
// Custom "dynamic variable" via scripting
pm.variables.set("orderId", "ORD-" + Date.now());
pm.variables.set("randomDiscount", Math.floor(Math.random() * 50));
```
Then reference `{{orderId}}` / `{{randomDiscount}}` in the URL/body just like any other variable.

## Practice Exercise

1. `POST https://postman-echo.com/post` with body:
```json
{ "id": "{{$guid}}", "name": "{{$randomFullName}}", "createdAt": "{{$isoTimestamp}}" }
```
2. Send it 3 times and compare the echoed `json` field each time — confirm every value is different.

Continue to → [3.4 Postman Vault & Secrets](04-postman-vault-secrets.md)

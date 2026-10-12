# 2.3 Request Body Types

The **Body** tab has several modes. Choosing the right one matters — it changes both how Postman serializes your data *and* the `Content-Type` header it sends.

## none
No body. Default for `GET`/`DELETE`/`HEAD`.

## form-data (`multipart/form-data`)
- Key/value table, but each **value can be text or a File**.
- Use this for **file uploads** (images, PDFs, CSVs) and for mimicking real HTML `<form>` submissions.
- Each field becomes its own "part" in the multipart body, each with its own `Content-Disposition` header — this is the only body type that supports binary file uploads alongside text fields in the same request.

Example use: uploading a profile picture plus a `caption` text field in one request.

## x-www-form-urlencoded
- Key/value table, text only, encoded like a URL query string in the body: `name=Ada&role=admin`.
- Sets `Content-Type: application/x-www-form-urlencoded`.
- Common for legacy web form submissions and some OAuth token endpoints (e.g., `grant_type=password&username=...`).

## raw
Free-text body, with a format dropdown: **Text / JavaScript / JSON / HTML / XML**. Choosing a format:
- Enables syntax highlighting + linting (e.g., JSON validity warnings).
- Auto-sets the matching `Content-Type` header (`application/json`, `application/xml`, etc.) — you can still override it manually in Headers if needed.

This is the most common mode for modern REST APIs:
```json
{
  "name": "Ada Lovelace",
  "email": "ada@example.com",
  "roles": ["admin", "editor"]
}
```

### Using Variables Inside Raw JSON
```json
{
  "name": "{{userName}}",
  "requestId": "{{$guid}}",
  "timestamp": "{{$timestamp}}"
}
```
Variables resolve before sending (Module 03 covers scopes; dynamic `$` variables are covered in 3.3).

## binary
- Upload a **single raw file** (image, zip, PDF, etc.) as the entire body, with no field wrapper.
- Common for endpoints like `PUT /files/{id}/content` that expect the raw bytes directly.
- Sets `Content-Type` based on the file (you can override).

## GraphQL
- A dedicated body mode with **Query** and **Variables** panes, plus a **schema introspection** button to auto-fetch and browse the API's GraphQL schema.
- Internally, Postman sends this as a POST with a JSON body shaped like:
```json
{
  "query": "query GetUser($id: ID!) { user(id: $id) { name email } }",
  "variables": { "id": "42" }
}
```
- See [Module 09: GraphQL](../09-advanced-protocols/01-graphql.md) for the full walkthrough.

## Choosing the Right Body Type — Quick Decision Table

| You need to... | Use |
|---|---|
| Send structured JSON to a modern REST API | `raw` → JSON |
| Upload a file along with some text fields | `form-data` |
| Upload just a raw file (no metadata) | `binary` |
| Submit like an old-school HTML form | `x-www-form-urlencoded` |
| Query a GraphQL endpoint | `GraphQL` |
| Send XML (SOAP or legacy APIs) | `raw` → XML |

## Practice Exercise

1. `POST https://postman-echo.com/post` with `raw` JSON body `{"a": 1, "b": 2}` — check the response `json` field.
2. `POST https://postman-echo.com/post` with `form-data`: a text field `title=hello` and a file field with any small file — check the response `files` and `form` fields.
3. `POST https://postman-echo.com/post` with `x-www-form-urlencoded`: `x=1&y=2` — check the response `form` field.

Continue to → [2.4 Response Handling](04-response-handling.md)

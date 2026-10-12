# 9.1 GraphQL in Postman

## Creating a GraphQL Request

1. **New → GraphQL Request** (or set an HTTP request's Body type to **GraphQL**).
2. Enter the endpoint URL (e.g., `https://api.example.com/graphql`).
3. Use the **Query** pane for your GraphQL query/mutation, and the **Variables** pane (JSON) for parameterized values.

## Example Query

**Query pane**:
```graphql
query GetUser($id: ID!) {
  user(id: $id) {
    id
    name
    email
    posts {
      title
      createdAt
    }
  }
}
```

**Variables pane**:
```json
{ "id": "{{userId}}" }
```

Postman variables (`{{userId}}`) work inside the Variables pane exactly like anywhere else.

## Example Mutation

```graphql
mutation CreateUser($input: CreateUserInput!) {
  createUser(input: $input) {
    id
    name
  }
}
```
```json
{ "input": { "name": "Ada Lovelace", "email": "ada@example.com" } }
```

## Schema Introspection

Click **"Use Introspection"** (or the schema icon) in the GraphQL request builder:
- Postman sends a standard GraphQL introspection query (`__schema { ... }`) to fetch the full schema.
- You get **autocomplete** for fields/types while writing queries, and can **browse the schema docs** (types, fields, descriptions) in a side panel — similar to GraphiQL/Apollo Studio, built into Postman.
- You can also manually paste/import a `.graphql` SDL file or a schema JSON if introspection is disabled on the server.

## What's Actually Sent Over the Wire

Regardless of the nice UI, a GraphQL request is just an HTTP `POST` with a JSON body:
```json
{
  "query": "query GetUser($id: ID!) { user(id: $id) { id name email } }",
  "variables": { "id": "42" }
}
```
You can confirm this in the Postman Console — useful for comparing behavior against raw `curl`/code-based GraphQL clients.

## Testing GraphQL Responses

GraphQL **always returns `200 OK`** even for most errors (errors appear inside the response body's `errors` array, not as an HTTP status code) — so your Tests scripts need a different pattern than typical REST status-code checks:

```js
const json = pm.response.json();

pm.test("No GraphQL errors", function () {
    pm.expect(json.errors).to.be.undefined;
});

pm.test("User data returned", function () {
    pm.expect(json.data.user).to.have.property("id");
    pm.expect(json.data.user.name).to.be.a('string');
});
```

## Authorization

GraphQL endpoints typically use the same Authorization tab mechanisms as REST (usually **Bearer Token**) — GraphQL itself doesn't define its own auth scheme, it rides on top of standard HTTP.

## Practice Exercise

Using a public GraphQL API (e.g., `https://countries.trevorblades.com/`):
1. Create a GraphQL request querying `countries { code name }`.
2. Confirm the response's `data.countries` is a non-empty array in a Test assertion.
3. Try introspection to browse the schema and discover a field you didn't know existed (e.g., `continent`).

Continue to → [9.2 WebSocket and Socket.IO](02-websocket-socketio.md)

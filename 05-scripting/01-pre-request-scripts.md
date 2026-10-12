# 5.1 Pre-request Scripts

## What They Are

A **Pre-request Script** is JavaScript that runs **immediately before** Postman sends the request. It runs inside the **Postman Sandbox** — a restricted Node-like JS environment (not full Node.js; no filesystem/network access except via the `pm` API).

Found in the **Pre-request Script** tab of a request, folder, or collection.

## Execution Order

```
Collection-level Pre-request Script
   └── Folder-level Pre-request Script
         └── Request-level Pre-request Script
               └── [Request is sent]
                     └── Request-level Test Script
               └── Folder-level Test Script
         └── Collection-level Test Script
```
Scripts execute **outer → inner** on the way in (collection first, then folder, then request), and **inner → outer** on the way out for Tests. This lets you set shared setup at the collection level and override/add specifics at the request level.

## Common Use Cases

### 1. Dynamically Set a Header/Timestamp
```js
pm.request.headers.add({
    key: "X-Request-Timestamp",
    value: new Date().toISOString()
});
```

### 2. Generate and Store a Request-Specific Value
```js
const orderId = "ORD-" + Math.floor(Math.random() * 1000000);
pm.variables.set("orderId", orderId);
// Now {{orderId}} is usable in the URL/body of THIS request
```

### 3. Fetch a Fresh Auth Token Before Each Request (Token Refresh Pattern)
```js
const tokenExpiry = pm.environment.get("tokenExpiry");
if (!tokenExpiry || Date.now() > Number(tokenExpiry)) {
    pm.sendRequest({
        url: pm.environment.get("baseUrl") + "/auth/token",
        method: "POST",
        header: { "Content-Type": "application/json" },
        body: {
            mode: "raw",
            raw: JSON.stringify({
                clientId: pm.environment.get("clientId"),
                clientSecret: pm.environment.get("clientSecret")
            })
        }
    }, function (err, res) {
        if (!err) {
            const json = res.json();
            pm.environment.set("accessToken", json.access_token);
            pm.environment.set("tokenExpiry", Date.now() + (json.expires_in * 1000));
        }
    });
}
```
> `pm.sendRequest()` lets a script make its own HTTP call — perfect for "refresh token if expired" logic that runs automatically before every protected request.

### 4. Build a Dynamic Request Body
```js
const payload = {
    name: pm.variables.replaceIn("{{$randomFullName}}"),
    submittedAt: new Date().toISOString()
};
pm.variables.set("generatedBody", JSON.stringify(payload));
// Reference {{generatedBody}} as the raw body, or use pm.request.body directly
```

### 5. Conditional Logic Based on Environment
```js
if (pm.environment.name === "Prod") {
    throw new Error("Refusing to run this destructive request against Prod!");
}
```

## Key Objects Available

| Object | Purpose |
|---|---|
| `pm.request` | The outgoing request — mutate headers, URL, body before it's sent |
| `pm.environment` / `pm.collectionVariables` / `pm.globals` / `pm.variables` | Read/write variables |
| `pm.sendRequest()` | Fire an additional async HTTP request from within the script |
| `pm.info` | Metadata: request name, iteration count, etc. |
| `console.log()` | Debug output, visible in the Postman Console |

> Full `pm` API reference in [5.3](03-pm-api-reference.md).

## Debugging Scripts

Use `console.log()` liberally, then open **View → Show Postman Console** to see output — this is the only reliable way to "see inside" a script's execution.

Continue to → [5.2 Test Scripts and Assertions](02-test-scripts-and-assertions.md)

# 5.2 Test Scripts and Assertions

## What They Are

**Test scripts** run **after** a response is received. They're written in the **Tests** tab (request/folder/collection level) and typically contain one or more `pm.test()` blocks whose pass/fail results populate the **Test Results** tab.

## Anatomy of a Test

```js
pm.test("Status code is 200", function () {
    pm.response.to.have.status(200);
});

pm.test("Response time is under 500ms", function () {
    pm.expect(pm.response.responseTime).to.be.below(500);
});

pm.test("Response has a user id", function () {
    const json = pm.response.json();
    pm.expect(json.id).to.exist;
    pm.expect(json.id).to.be.a('number');
});
```

Each `pm.test(name, fn)` block is independently reported pass/fail — one failing assertion doesn't stop the others from running.

## The Assertion Library: Chai (`pm.expect`)

Postman bundles **Chai's BDD assertion style**, exposed as `pm.expect()`:

```js
pm.expect(1).to.equal(1);
pm.expect("hello").to.be.a('string');
pm.expect([1,2,3]).to.include(2);
pm.expect(json.roles).to.be.an('array').that.is.not.empty;
pm.expect(json.email).to.match(/^[^@]+@[^@]+\.[^@]+$/);
pm.expect(json.active).to.be.true;
pm.expect(json.deletedAt).to.be.null;
pm.expect(response).to.have.property('token');
```

## Postman's Built-in Response Assertion Shorthand (`pm.response.to`)

```js
pm.response.to.have.status(200);
pm.response.to.have.status('OK');            // matches by status text
pm.response.to.be.success;                    // 2xx
pm.response.to.be.error;                      // 4xx/5xx
pm.response.to.have.header("Content-Type");
pm.response.to.have.jsonBody();
pm.response.to.have.jsonSchema(mySchema);     // validate against a JSON Schema
```

## Common Patterns

### Validate Response Structure (Schema Validation)
```js
const schema = {
    type: "object",
    required: ["id", "name", "email"],
    properties: {
        id: { type: "number" },
        name: { type: "string" },
        email: { type: "string" }
    }
};

pm.test("Schema is valid", function () {
    pm.response.to.have.jsonSchema(schema);
});
```

### Extract and Chain Data to the Next Request
```js
const json = pm.response.json();
pm.environment.set("createdUserId", json.id);
// The NEXT request in the collection can now use {{createdUserId}}
```

### Conditional / Skipped Tests
```js
if (pm.response.code === 200) {
    pm.test("Returned a non-empty list", function () {
        pm.expect(pm.response.json().length).to.be.above(0);
    });
}
```

### Testing Array Responses
```js
const json = pm.response.json();
pm.test("All items have a positive price", function () {
    json.forEach(item => {
        pm.expect(item.price).to.be.above(0);
    });
});
```

### Asserting Response Headers
```js
pm.test("Content-Type is JSON", function () {
    pm.expect(pm.response.headers.get("Content-Type")).to.include("application/json");
});
```

### Asserting on Error Responses
```js
pm.test("Returns 404 for missing resource", function () {
    pm.response.to.have.status(404);
    pm.expect(pm.response.json().error).to.eql("Not Found");
});
```

## Snippets Panel

The right-hand **Snippets** sidebar in the Tests/Pre-request tabs has one-click inserts for all the above patterns (status code check, response time check, JSON value check, schema validation, etc.) — a great way to discover syntax without memorizing everything.

## Reading Test Results

- **Per-request**: Test Results tab shows `X/Y passed` with a green check or red cross per test.
- **Collection Runner**: aggregates pass/fail across every request + iteration into a summary table (Module 07).
- **Newman**: prints pass/fail to the terminal and can output JSON/HTML/JUnit reports for CI dashboards (Module 07.3).

## Practice Exercise

1. `GET https://postman-echo.com/get?foo=bar`
2. In Tests, write 3 assertions:
   - Status code is 200
   - Response time is below 1000ms
   - `args.foo` in the response equals `"bar"`
3. Confirm all 3 pass in the Test Results tab.
4. Intentionally break one (change `bar` to `baz`) and confirm it now fails with a clear message.

Continue to → [5.3 Postman Sandbox / pm API Reference](03-pm-api-reference.md)

# 5.3 The Postman Sandbox & `pm` API Reference

## What Is the Sandbox?

The **Postman Sandbox** is the JavaScript execution environment for pre-request/test scripts. It is:
- Based on Node.js **but restricted** — no `fs`, no arbitrary network modules, no `require()` of arbitrary npm packages.
- Pre-loaded with a curated set of libraries: `lodash`, `crypto-js`, `cheerio`, `tv4`/`ajv` (JSON Schema), `chai` (assertions), `xml2js`, `postman-collection`.
- Shared across pre-request and test scripts via the global `pm` object.

## The `pm` Object — Full Reference

### Request Info (read in Tests, read/write in Pre-request)
```js
pm.request.url.toString();          // full URL as a string
pm.request.url.getPath();           // just the path
pm.request.url.query.get("page");   // get a query param
pm.request.method;                  // "GET", "POST", etc.
pm.request.headers.get("Content-Type");
pm.request.headers.add({ key: "X-Custom", value: "1" });
pm.request.headers.remove("X-Custom");
pm.request.body;                    // body object (mode, raw, etc.)
```

### Response Info (Tests only)
```js
pm.response.code;            // 200, 404, etc.
pm.response.status;          // "OK", "Not Found"
pm.response.responseTime;    // ms
pm.response.responseSize;    // bytes
pm.response.headers.get("Content-Type");
pm.response.text();          // raw body as string
pm.response.json();          // parsed JSON body (throws if not valid JSON)
```

### Variables (all scopes)
```js
pm.globals.get/set/unset/clear
pm.collectionVariables.get/set/unset/clear
pm.environment.get/set/unset/clear
pm.variables.get(key)      // reads with scope precedence (local > data > env > collection > global)
pm.variables.set(key, val) // sets a LOCAL (script-only) variable
pm.variables.replaceIn("{{baseUrl}}/users") // resolve variables inside a string
```

### Environment Metadata
```js
pm.environment.name     // currently active environment's name
pm.environment.id
```

### Iteration / Data (Collection Runner / Newman context)
```js
pm.info.iteration;          // current iteration number (0-indexed)
pm.info.iterationCount;     // total iterations
pm.info.requestName;        // name of the current request
pm.iterationData.get("email"); // value from the current row of the data file
```

### Cookies
```js
pm.cookies.has("session");
pm.cookies.get("session");
pm.cookies.toObject();
```

### Sending Additional Requests
```js
pm.sendRequest("https://postman-echo.com/get", function (err, response) {
    console.log(response.json());
});

// Or with a full request object:
pm.sendRequest({
    url: "https://postman-echo.com/post",
    method: "POST",
    header: { "Content-Type": "application/json" },
    body: { mode: "raw", raw: JSON.stringify({ a: 1 }) }
}, function (err, res) { /* ... */ });
```

### Visualizer
```js
pm.visualizer.set(templateHtmlString, dataObject);
```
(Full walkthrough in [5.5](05-visualizer.md).)

### Execution Control
```js
pm.execution.setNextRequest("Request Name"); // jump to a specific request next (Collection Runner)
pm.execution.setNextRequest(null);           // stop the run after this request
```

### Assertions
```js
pm.test(name, fn)
pm.expect(value)   // Chai BDD assertions
```

## Libraries Available via `require()`

```js
const _ = require('lodash');
const moment = require('moment');          // (bundled in classic sandbox; check version docs)
const CryptoJS = require('crypto-js');
const cheerio = require('cheerio');        // HTML/XML parsing, jQuery-like API
const xml2js = require('xml2js');
```

> Not all npm packages are available — only the curated set Postman bundles. Check **Postman docs → Sandbox API Reference** for the current exact list, since it evolves between app versions.

## Script Execution Limits

- Scripts have a timeout (a few seconds) to prevent runaway loops from hanging a run.
- `pm.sendRequest()` calls are asynchronous — if you need the result before the main request proceeds (pre-request script), you must structure logic to wait on the callback; the main request won't fire until the pre-request script's call stack + any pending async callbacks resolve.
- Avoid heavy computation (e.g., giant loops) in scripts running across thousands of Collection Runner iterations — it will materially slow down the run.

Continue to → [5.4 Chaining Requests](04-chaining-requests.md)

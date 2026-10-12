# 7.2 Data-Driven Testing

## The Core Idea

Instead of hardcoding one set of test values, you supply a **data file** (CSV or JSON) where **each row/object becomes one iteration** of the Collection Runner — the same requests run once per row, with that row's values substituted in via variables.

## CSV Data File Example

`users.csv`:
```csv
name,email,expectedRole
Ada Lovelace,ada@example.com,admin
Grace Hopper,grace@example.com,editor
Alan Turing,alan@example.com,viewer
```

## JSON Data File Example (equivalent, supports nesting)

```json
[
  { "name": "Ada Lovelace", "email": "ada@example.com", "expectedRole": "admin" },
  { "name": "Grace Hopper", "email": "grace@example.com", "expectedRole": "editor" },
  { "name": "Alan Turing", "email": "alan@example.com", "expectedRole": "viewer" }
]
```
> Use JSON when you need nested objects/arrays per row — CSV only supports flat key/value columns.

## Referencing Data File Columns in Requests

Each column name becomes a variable automatically available during that iteration — **referenced exactly like any other variable**:
```
Body: { "name": "{{name}}", "email": "{{email}}" }
```

In scripts, access it explicitly via `pm.iterationData`:
```js
const expectedRole = pm.iterationData.get("expectedRole");
pm.test(`Role matches expected: ${expectedRole}`, function () {
    pm.expect(pm.response.json().role).to.eql(expectedRole);
});
```

## Running With a Data File

1. Open the **Collection Runner**.
2. Click **Select File** under the Data section, choose your `.csv`/`.json`.
3. Postman auto-detects the row count and sets **Iterations** to match (one iteration per row) — you can still override manually.
4. Run — each iteration's Test Results are tagged by iteration number so you can see exactly which data row caused which failure.

## Data-Driven Testing with Newman

```bash
newman run collection.json -e environment.json -d users.csv
```
Same concept, fully scriptable for CI — see [7.3 Newman CLI](03-newman-cli.md).

## Best Practices

1. **Keep test data files in version control** alongside the collection — treat them as test fixtures, reviewed the same way as code.
2. **Include both valid and invalid rows** to test both happy-path and error-handling behavior in one run (e.g., a row with a malformed email to confirm the API correctly rejects it).
3. **Avoid PII/real user data** in committed data files — use clearly fake data (see dynamic variables, Module 3.3, for generating it if needed) or anonymized test fixtures only.
4. **Name columns to match variable names exactly** used in requests — mismatches silently resolve to `undefined`/literal `{{column}}` text, a very common and confusing bug.

## Practice Exercise

1. Create `test-users.csv` with columns `fullName,email`.
2. Build a request `POST https://postman-echo.com/post` with body `{"name": "{{fullName}}", "email": "{{email}}"}`.
3. Run via Collection Runner with this CSV as the data file, 1 iteration per row.
4. In Tests, assert the echoed `json.name` equals `{{fullName}}` for that iteration.

Continue to → [7.3 Newman CLI](03-newman-cli.md)

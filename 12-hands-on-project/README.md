# 12. Hands-On Project

A real, runnable Postman collection that puts every concept from Modules 01–11 into practice against the public [`postman-echo.com`](https://postman-echo.com) service — no account, API key, or real backend required.

## What's Inside

```
12-hands-on-project/
├── collections/
│   └── PostmanMastery.postman_collection.json   # The full collection
├── environments/
│   ├── dev.postman_environment.json              # Dev environment (used by default)
│   └── prod.postman_environment.json             # Prod environment (placeholder secret)
├── data/
│   └── users.csv                                 # Data file for data-driven testing
└── newman/
    └── run-newman.sh                             # One-command local Newman runner
```

## What the Collection Demonstrates

| Folder | Concepts |
|---|---|
| **01 - Fundamentals** | GET/POST, query params, raw JSON body, basic test assertions |
| **02 - Authorization** | Basic Auth, Bearer Token (and a note on how postman-echo redacts the `Authorization` header value in its response for security) |
| **03 - Scripting and Dynamic Variables** | Pre-request script generating a correlation ID, dynamic variables (`{{$guid}}`, `{{$randomFullName}}`, `{{$randomEmail}}`), and **request chaining** — the second request depends on data extracted from the first |
| **04 - Data-Driven Testing** | A request driven by `data/users.csv`, asserting each iteration's data matches what was echoed back |
| **05 - Error Handling** | Asserting on an *expected* non-2xx response (`/status/500`) |

It also includes a **collection-level pre-request script** (logs the current request/iteration) and a **collection-level test script** (a global response-time assertion applied to every request) — demonstrating inherited scripts from [Module 05](../05-scripting/01-pre-request-scripts.md).

## Running It — Option 1: Postman GUI

1. **File → Import** → select both:
   - `collections/PostmanMastery.postman_collection.json`
   - `environments/dev.postman_environment.json`
2. Select the **Dev** environment in the top-right dropdown.
3. Open the collection → **Run** → under **Data**, select `data/users.csv` → **Run Postman Mastery - Hands-On Project**.
4. Review the pass/fail summary (expect **all assertions to pass**).

## Running It — Option 2: Newman (Command Line)

```bash
npm install -g newman newman-reporter-htmlextra
cd 12-hands-on-project
./newman/run-newman.sh          # runs against Dev
./newman/run-newman.sh prod     # runs against Prod
```

This generates `newman/reports/newman-results.xml` (JUnit) and `newman/reports/newman-report.html` (rich HTML report) — both gitignored since they're build artifacts, not source.

**Verified output** (last run against this exact collection): `3 iterations, 24 requests, 78/78 assertions passed, 0 failures`.

## Running It — Option 3: GitHub Actions (Already Set Up)

Push this repo to GitHub and the included [`.github/workflows/newman-ci.yml`](../.github/workflows/newman-ci.yml) workflow runs automatically on every push/PR to `main`, uploading the Newman reports as a downloadable build artifact. See [Module 7.4](../07-running-and-automation/04-ci-cd-integration.md) for a full breakdown of how it works.

## Extending the Project

Good next exercises once you're comfortable with the existing collection:
1. Add a new folder `06 - OAuth 2.0` with a request configured against a free public OAuth provider (e.g., GitHub) — see [Module 4.4](../04-authorization/04-oauth1-oauth2.md).
2. Add a saved example response to any request and spin up a **Mock Server** from this collection — see [Module 08](../08-mocking-and-monitoring/01-mock-servers.md).
3. Add a **Monitor** on this collection scheduled every 15 minutes — see [Module 7.5](../07-running-and-automation/05-monitors.md).
4. Build a **Postman Flow** that visually replicates the "Create Fake User → Fetch Generated User" chain — see [Module 11](../11-postman-flows/01-flows-intro.md).

# 7.3 Newman — The Command-Line Collection Runner

## What It Is

**Newman** is Postman's official Node.js command-line tool that runs exported collections **outside the GUI** — the critical bridge between "I tested this manually in Postman" and "this runs automatically in CI/CD on every commit."

## Installing Newman

```bash
npm install -g newman
```
Verify:
```bash
newman --version
```

## Basic Usage

```bash
newman run MyCollection.postman_collection.json
```

### With an Environment
```bash
newman run MyCollection.postman_collection.json -e Dev.postman_environment.json
```

### With a Data File (Data-Driven)
```bash
newman run MyCollection.postman_collection.json -e Dev.postman_environment.json -d users.csv
```

### With Iterations and Delay
```bash
newman run MyCollection.postman_collection.json -n 5 --delay-request 200
```

### Overriding a Single Variable from the CLI
```bash
newman run MyCollection.postman_collection.json --env-var "baseUrl=https://staging-api.example.com"
```

### Setting a Global Timeout
```bash
newman run MyCollection.postman_collection.json --timeout-request 5000
```

## Reading Newman's Terminal Output

```
→ Create User
  POST https://postman-echo.com/post [200 OK, 1.2kB, 312ms]
  ✓  Status code is 201
  ✗  Response has user id
     AssertionError: expected undefined to exist

┌─────────────────────────┬──────────────────┬──────────────────┐
│                         │         executed │            failed │
├─────────────────────────┼──────────────────┼──────────────────┤
│              iterations │                 1 │                  0 │
│                requests │                 1 │                  0 │
│            test-scripts │                 1 │                  0 │
│      prerequest-scripts │                 1 │                  0 │
│              assertions │                 2 │                  1 │
└─────────────────────────┴──────────────────┴──────────────────┘
```
Exit code is **non-zero if any assertion fails** — this is exactly what makes Newman useful as a CI gate (a failing API test can fail the build).

## Generating Reports

Newman supports pluggable reporters:
```bash
npm install -g newman-reporter-htmlextra

newman run MyCollection.postman_collection.json \
  -e Dev.postman_environment.json \
  -r cli,htmlextra,junit \
  --reporter-htmlextra-export ./newman-report.html \
  --reporter-junit-export ./newman-report.xml
```

| Reporter | Output | Use case |
|---|---|---|
| `cli` (default) | Terminal text | Local runs, quick feedback |
| `json` | Structured JSON | Programmatic post-processing |
| `junit` | JUnit XML | CI dashboards (Jenkins, GitLab, Azure DevOps all understand this format natively) |
| `htmlextra` (community) | Rich HTML report | Human-readable artifact to attach to a CI build or share with stakeholders |

## Running Newman via Docker (No Local Node.js Needed)

```bash
docker run -v $(pwd):/etc/newman -t postman/newman run MyCollection.postman_collection.json -e Dev.postman_environment.json
```
Useful in CI environments where you don't want to manage a Node.js install just for test runs.

## Newman as a Node.js Library (Programmatic Use)

```js
const newman = require('newman');

newman.run({
    collection: require('./MyCollection.postman_collection.json'),
    environment: require('./Dev.postman_environment.json'),
    reporters: 'cli'
}, function (err, summary) {
    if (err) { throw err; }
    console.log('Collection run complete!');
    console.log(`Failures: ${summary.run.failures.length}`);
});
```
Useful when you want custom logic around a run (e.g., posting results to Slack, triggering alerts) beyond what CLI flags provide.

## Common Newman Flags Cheat Sheet

| Flag | Purpose |
|---|---|
| `-e, --environment` | Environment file |
| `-g, --globals` | Globals file |
| `-d, --iteration-data` | Data file (CSV/JSON) |
| `-n, --iteration-count` | Number of iterations |
| `--folder` | Run only a specific folder |
| `--bail` | Stop on first failure |
| `--insecure` | Disable SSL certificate verification |
| `--delay-request` | Delay (ms) between requests |
| `--timeout-request` | Per-request timeout (ms) |
| `-r, --reporters` | Comma-separated reporters |
| `--export-environment` | Save the environment's final variable state after the run |

## Practice Exercise

1. Export `Practice - Postman Echo` collection + its environment.
2. Run: `newman run Practice-Postman-Echo.postman_collection.json -e Dev.postman_environment.json`
3. Confirm the terminal summary matches what you saw in the GUI Collection Runner.
4. Add `-r cli,junit --reporter-junit-export results.xml` and inspect the generated XML file.

Continue to → [7.4 CI/CD Integration](04-ci-cd-integration.md)

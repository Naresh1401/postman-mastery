# 13.2 Interview Questions and Answers

## Fundamentals

**Q: What is Postman and why would you use it over `curl`?**
A: Postman is a GUI API client/platform that layers organization (collections), reusability (variables/environments), automation (Runner/Newman), scripting (pre-request/test scripts), and collaboration on top of raw HTTP requests. `curl` is great for one-off command-line calls but doesn't natively manage saved requests, environment switching, chained data, or automated regression testing.

**Q: What's the difference between a Collection, an Environment, and a Workspace?**
A: A **Collection** is a saved, organized group of requests. An **Environment** is a named set of variables (e.g., Dev/Staging/Prod) that requests reference via `{{variable}}`. A **Workspace** is a container holding collections, environments, mock servers, and monitors — used for project/team organization.

**Q: Explain variable scope precedence in Postman.**
A: Local > Data > Environment > Collection > Global (most specific wins). Local variables exist only during a single script execution; Data variables come from a Collection Runner/Newman data file per iteration; Environment is the active environment's values; Collection variables apply regardless of active environment; Globals apply across the entire workspace.

## HTTP / REST

**Q: What's the difference between PUT and PATCH?**
A: PUT replaces the entire resource (you should send the full representation); PATCH applies a partial update (only the changed fields). PUT is idempotent by definition; PATCH's idempotency depends on implementation.

**Q: 401 vs 403 — what's the difference?**
A: 401 Unauthorized means authentication failed or wasn't provided (the server doesn't know who you are). 403 Forbidden means the server recognized you but you don't have permission to perform the action.

**Q: Is a GraphQL request a GET or a POST?**
A: Typically POST (even for "queries"), since the query/variables are sent as a JSON body. The HTTP status is usually always 200, with errors reported inside the `errors` array of the response body rather than via HTTP status codes.

## Scripting

**Q: What's the difference between a pre-request script and a test script?**
A: A pre-request script runs before the request is sent (setup: generate data, refresh tokens, add dynamic headers). A test script runs after the response arrives (assertions, extracting data for the next request, chaining).

**Q: How do you chain requests in Postman — pass data from one request to the next?**
A: In the first request's Tests script, extract a value from the response and store it in an Environment/Collection variable (e.g., `pm.environment.set("userId", pm.response.json().id)`), then reference `{{userId}}` in the next request's URL/body/headers.

**Q: What assertion library does Postman use, and how do you access it?**
A: Chai (BDD style), accessed via `pm.expect()`. Postman also provides shorthand helpers like `pm.response.to.have.status(200)`.

**Q: How would you control the execution order of requests during a Collection Runner run, including conditional branching?**
A: Use `pm.execution.setNextRequest("Request Name")` in a Tests script to jump to a specific request, or `pm.execution.setNextRequest(null)` to stop the run early. Combine with `if` logic reading the response to branch conditionally (e.g., poll until a job status is "complete").

## Authentication

**Q: How does Postman handle OAuth 2.0 token refresh automatically?**
A: In the OAuth 2.0 Authorization config, you can enable "Automatically refresh this token when expired" — Postman will silently request a new access token via the refresh token flow when a request gets a 401/expired-token response, without manual re-authentication.

**Q: Where should secrets never be stored in a Postman collection, and why?**
A: Never in a Collection/Environment variable's "Initial Value" field — that gets saved into the exported/synced JSON and can leak via Git commits or team sync. Use "Current Value" only (not exported) or Postman Vault (`{{vault:key}}`, local-only, never synced/exported).

## Automation / CI-CD

**Q: What is Newman and why is it important for CI/CD?**
A: Newman is Postman's official Node.js CLI Collection Runner — it runs an exported collection headlessly from the command line, returning a non-zero exit code if any test assertion fails. This lets CI/CD pipelines (GitHub Actions, Jenkins, GitLab CI, etc.) gate deploys/merges on API test results automatically.

**Q: How do you do data-driven testing in Postman?**
A: Provide a CSV or JSON data file to the Collection Runner (or Newman's `-d` flag) — each row/object becomes one iteration, with its columns/keys available as variables (`{{columnName}}`) and via `pm.iterationData.get()`.

**Q: What's the difference between a Monitor and running Newman in a CI pipeline?**
A: A Monitor runs on a time-based schedule in Postman's cloud, independent of code deploys — good for ongoing uptime/health checks. Newman in CI runs triggered by code events (push/PR) — good for gating merges/deploys on test results. They're complementary, not interchangeable.

## Advanced / Design

**Q: How would you test an endpoint that returns different responses asynchronously (e.g., a job that needs polling)?**
A: Chain a "Check Status" request that re-calls itself via `pm.execution.setNextRequest("Check Status")` if the job isn't done yet, combined with a short delay, until the status changes — then proceed to the next step (Module 5.4 polling pattern), or build the same logic visually with Postman Flows' loop blocks.

**Q: How do Mock Servers work, and what's a realistic use case?**
A: A Mock Server returns pre-saved example responses for requests matching a collection's structure, without a real backend. Realistic use case: frontend team builds against the mock while the backend team is still implementing the real API, based on an agreed contract — unblocking parallel development.

**Q: What would you check first if a request works manually in Postman's GUI but fails when run via Newman in CI?**
A: Compare the active environment file passed to Newman vs. the one selected in the GUI (common root cause); check for any variables that were only ever set interactively/manually and never actually in an environment/collection variable; check network/firewall differences between your local machine and the CI runner; and verify secrets were passed via `--env-var`/CI secrets rather than assumed to exist.

Continue to → [13.3 Troubleshooting Guide](03-troubleshooting.md)

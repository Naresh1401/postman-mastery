# 7.5 Monitors

## What a Monitor Is

A **Monitor** runs a collection on a **schedule**, in Postman's cloud (no local app, CI system, or server of your own required) — purpose-built for ongoing **uptime/health checks** and **synthetic monitoring** of an API.

## Creating a Monitor

1. Sidebar → **Monitors** → **Create Monitor**.
2. Choose the **Collection** (and optionally a specific **Environment**) to run.
3. Set a **Schedule**: every 5/15/30/60 minutes, hourly, daily, or a custom cron-like interval (frequency options depend on your plan).
4. Choose **Region(s)** to run from (useful for checking latency/availability from multiple geographies).
5. Configure **Email notifications** — alert specific people/distribution lists when the run fails or exceeds a response-time threshold.
6. Save — Postman now runs this collection automatically, forever, on schedule.

## What You Get From a Monitor Run

- Pass/fail history over time, viewable as a timeline/chart.
- Response time trends — spot creeping latency regressions before users complain.
- Automatic email/webhook alerts on failure.
- A public **status page** option (on applicable plans) to share uptime history externally.

## Monitors vs Newman-in-CI vs Collection Runner — When to Use Which

| Tool | Trigger | Best for |
|---|---|---|
| **Collection Runner (GUI)** | Manual click | Ad-hoc exploratory testing while developing |
| **Newman in CI/CD** | Code push / PR / merge | Gatekeeping — "don't merge/deploy if API tests fail" |
| **Monitor** | Time-based schedule, independent of deploys | Continuous production health/uptime checks, SLA monitoring, catching issues caused by *anything* (not just your own deploys — e.g., a third-party dependency outage, cert expiry, DNS issues) |

They're complementary, not redundant — a mature setup typically uses **all three**.

## Practical Monitor Use Cases

1. **Uptime check**: `GET /health` every 5 minutes, alert if status isn't `200` or body doesn't match expected shape.
2. **Certificate expiry early warning**: a scheduled check that fails (or logs a warning) if an SSL cert is within N days of expiring (via a pre-request/test script inspecting response TLS info where supported, or an external cert-check endpoint).
3. **Third-party dependency monitoring**: schedule a Monitor against a partner/vendor API your system depends on, so you get alerted to *their* outages before your own users report problems caused by it.
4. **Scheduled data integrity checks**: run a collection that queries production and asserts invariants (e.g., "order count should never be negative") on a recurring basis.

## Limitations to Keep in Mind

- Monitors run from **Postman's cloud infrastructure**, so they can't reach purely internal/private network APIs unless you expose them (or use an on-prem agent solution where available on enterprise plans).
- Monitor run frequency/regions available depend on your Postman plan tier.
- Monitors execute the collection largely like Newman would — pre-request/test scripts behave the same, but there's no "headful" UI to watch live.

## Practice Exercise

1. Create a Monitor on your `Practice - Postman Echo` collection.
2. Schedule it to run every 15 minutes (or the shortest interval your plan allows) against the `Dev` environment.
3. After it runs at least once, check the Monitor's run history to confirm the pass/fail and response-time trend are visible.

---
This completes Module 07. Continue to → [Module 08: Mocking & Monitoring](../08-mocking-and-monitoring/01-mock-servers.md)

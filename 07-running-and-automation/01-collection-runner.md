# 7.1 Collection Runner

## What It Is

The **Collection Runner** executes every request in a collection (or a selected folder) sequentially, without manually clicking Send on each one — essential for regression testing and before any CI automation.

## Opening the Runner

- Click **Run** on a collection (or folder), or
- Sidebar → Collections → "..." → **Run collection**, or
- The standalone **Runner** button in the top bar.

## Runner Configuration Options

| Option | What it controls |
|---|---|
| **Environment** | Which environment's variables are active during the run |
| **Iterations** | How many times to repeat the entire selected request set (default 1) |
| **Delay** | Milliseconds to wait between each request (avoid rate-limiting / give async operations time) |
| **Data File** | CSV/JSON file to drive data-driven testing (Module 7.2) |
| **Keep variable values** | Whether variable changes persist after the run ends (useful to inspect final state) |
| **Save responses** | Store each response for later inspection |
| **Request selection** | Checkbox tree to include/exclude specific requests/folders from this run |

## Reading the Run Summary

After a run completes, Postman shows:
- **Pass/Fail counts** per request (how many `pm.test()` assertions passed vs failed)
- **Total requests sent**, average response time
- A per-request breakdown you can expand to see exact failure messages
- **Export Results** — save the run summary as JSON for later analysis

## Typical Use Cases

1. **Regression testing**: run the full collection after every deploy to confirm nothing broke.
2. **Load-lite smoke testing**: run with high iteration counts and a short delay to spot-check stability (not a substitute for a real load-testing tool like k6/JMeter, but useful for quick sanity checks).
3. **Data-driven validation**: run once per row of a CSV to test many input combinations against the same request shape (Module 7.2).

## Handling Failures Mid-Run

By default, the Runner **continues** executing subsequent requests even if an earlier one fails assertions (it does NOT stop like a typical test suite would on first failure) — this is usually desirable so you get a full picture of everything that's broken, not just the first failure. If a request **errors entirely** (e.g., connection refused), remaining chained requests dependent on its variables will likely also fail — expected cascading behavior, not a bug.

## Scheduling Runs Without a Human Present

The GUI Collection Runner requires the desktop app to be open. For truly unattended, scheduled, or CI-triggered runs, use:
- **Newman** (Module 7.3) — CLI tool, works anywhere Node.js runs, perfect for CI/CD.
- **Monitors** (Module 7.5) — Postman's own cloud-hosted scheduler, no local app or CI system needed.

## Practice Exercise

1. Open the Runner on your `Practice - Postman Echo` collection.
2. Set Iterations = 3, Delay = 200ms.
3. Run it and review the pass/fail summary — confirm your assertions from Module 05 ran 3 times each.

Continue to → [7.2 Data-Driven Testing](02-data-driven-testing.md)

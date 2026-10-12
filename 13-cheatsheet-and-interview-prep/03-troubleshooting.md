# 13.3 Troubleshooting Guide

## "My variable shows as `{{foo}}` literally instead of its value"

**Cause**: the variable is undefined in every active scope, or there's a typo/case mismatch.
**Fix**:
1. Hover the `{{foo}}` text — Postman shows a tooltip with its resolved value and source scope, or flags it orange if unresolved.
2. Check the active **Environment** is actually the one you think it is (top-right dropdown).
3. Check for exact spelling/case match — `baseUrl` ≠ `baseURL` ≠ `base_url`.

## "I'm getting 401 Unauthorized but my credentials are correct"

1. Open the **Postman Console** and inspect the *actual* `Authorization` header sent — confirm it's formatted as expected (no extra whitespace, correct `Bearer `/`Basic ` prefix).
2. Check token **expiry** — decode a JWT at a safe/offline tool to inspect `exp`.
3. Confirm you're pointed at the right **environment** (a Dev token won't work against Prod, and vice versa).
4. Confirm the auth type selected (Basic/Bearer/API Key/etc.) actually matches what the server expects.

## "Works in Postman GUI but fails in Newman/CI"

1. Compare the environment file passed to Newman vs. the one active in the GUI — a stale or wrong file is the #1 cause.
2. Check if any value only exists because you **manually typed it into Current Value** during a GUI session (never saved to Initial Value or the exported environment file) — Newman only sees what's in the exported file (plus `--env-var` overrides).
3. Check for **network/firewall differences** — CI runners often can't reach internal/VPN-only hosts your laptop can.
4. Check for **SSL certificate issues** — add `--insecure` temporarily to confirm/rule this out (don't leave it permanently without understanding why it was needed).

## "SSL certificate verification failed"

- For **local/dev servers with self-signed certs**: Settings → General → turn OFF "SSL certificate verification" (dev-only; never disable for real production testing).
- In Newman: `--insecure` flag.
- For a specific untrusted cert you want to trust properly: Settings → Certificates → add a **Client Certificate** or CA cert for that host instead of disabling verification globally.

## "My test script throws `pm.response.json() is not a function` or similar"

**Cause**: the response body isn't valid JSON (e.g., it's XML, HTML, an empty body, or an error page).
**Fix**: `console.log(pm.response.text())` first to see the raw body, confirm the `Content-Type`, and only call `.json()` once you've confirmed it's actually JSON (wrap in a try/catch if the shape is unpredictable).

## "Collection Runner / Newman behaves differently than I expect with chained variables"

**Cause**: usually a leftover variable value from a previous run polluting the current one (stale `userId`, expired token, etc.), or a race condition if running in parallel.
**Fix**: add explicit cleanup (`pm.environment.unset(...)`) at the end of a chain, or use `{{$guid}}`-based unique values per run to avoid any collision with previous state.

## "My request body isn't being sent the way I expect"

1. Confirm the **Body tab mode** matches what you intend (raw/JSON vs form-data vs x-www-form-urlencoded) — these are NOT interchangeable even if the visible text looks similar.
2. Check the `Content-Type` header isn't conflicting — Postman sets this automatically based on the Body mode, but a manually-added header can override it incorrectly.
3. Use the Console to see the *exact* bytes sent.

## "CORS error" — but only in Postman Web, not Desktop

**Cause**: Postman Web runs in a browser context and is subject to the same-origin policy for some operations; the native Desktop app is not.
**Fix**: Install/enable the **Postman Desktop Agent** when using Postman Web, or switch to the Desktop app entirely for affected requests.

## "Dynamic variable `{{$randomX}}` isn't resolving / looks wrong"

- Dynamic variables only resolve **at send time** — if you're inspecting them in a context that doesn't trigger a send (e.g., just typing in a field without sending), you won't see a resolved value yet; this is expected, not a bug.
- Confirm correct spelling (`{{$randomFullName}}`, not `{{$fullName}}`) — use the `{{$` autocomplete dropdown to avoid typos entirely.

## "Newman JUnit/HTML report isn't generated"

1. Confirm the reporter package is installed (`npm install -g newman-reporter-htmlextra` for `htmlextra` specifically — it's a separate package from core Newman).
2. Confirm you passed both `-r <reporter-name>` **and** the matching `--reporter-<name>-export <path>` flag — a common mistake is specifying the reporter but forgetting the export path flag.

## "Mock Server returns a generic 404 instead of my saved example"

1. Check the **Call Logs** for the mock server — confirms exactly what path/method was received vs. expected.
2. Confirm an **example response is saved** on the matching request (mocks only return saved examples, not live/dynamic logic).
3. If multiple examples exist for the same method+path, force the right one via the `x-mock-response-name` header.

## General Debugging Habit

> Whenever something doesn't behave as expected: **open the Postman Console first** (`Cmd/Ctrl+Alt+C`). It shows the literal request sent and response received — most "mystery" bugs are solved in under a minute once you see the raw wire data instead of guessing.

---
This completes Module 13 and the full curriculum. Return to the → [Main README](../README.md) for the full learning path, or dive into the → [Hands-On Project](../12-hands-on-project/) to practice everything end-to-end.

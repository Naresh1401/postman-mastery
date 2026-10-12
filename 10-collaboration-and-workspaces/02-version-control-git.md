# 10.2 Version Control with Git

## Two Ways to Think About "Postman + Git"

1. **Native Postman version control** — built-in collection history/forking within Postman itself (no Git involved, works automatically in team workspaces).
2. **Exporting to an actual Git repository** — treating your collection/environment JSON files as source code, committed and reviewed like any other code (what this repo itself demonstrates in [Module 12](../12-hands-on-project/)).

Most mature teams use **both**: Postman's native collaboration day-to-day, with periodic/CI-triggered exports into Git for durable history, code review, and CI/CD integration.

## Native Postman Version Control (Fork & Pull Request)

1. **Fork** a collection: right-click → **Create a Fork** → name it (e.g., `feature/add-refund-endpoint`).
2. Make changes in your fork in isolation — the source collection is unaffected.
3. When ready, **Create Pull Request** (from the fork's "..." menu) — this opens a Postman-native review UI showing a diff of changes (added/removed/modified requests, scripts, variables).
4. A reviewer comments/approves, then **merges** the fork back into the source collection.
5. **Pull updates** from source into your fork at any time to stay in sync (like `git pull` on a feature branch).

This mirrors a standard Git feature-branch workflow, entirely within Postman's UI — no external Git repo required for this layer.

## Git-Based Export Workflow

### Exporting
```bash
# Manually, or automated via the Postman API (see 10.3)
# File → Export → Collection v2.1 → save as collection.json
```

### Repository Layout Convention
```
my-api-tests/
├── collections/
│   └── MyAPI.postman_collection.json
├── environments/
│   ├── dev.postman_environment.json
│   └── staging.postman_environment.json
├── data/
│   └── test-users.csv
└── .github/workflows/newman-ci.yml
```

### Committing Collections — What to Watch For
- **Diff noise**: Postman regenerates internal IDs/ordering on every export even without "real" changes — expect somewhat noisy diffs; focus code review on the meaningful parts (URLs, scripts, assertions, variable names).
- **Never commit real secrets** — sanitize environment files before committing (placeholder/empty values for anything sensitive; see [3.4](../03-variables-and-environments/04-postman-vault-secrets.md)).
- **Pretty-print the JSON** before committing (most editors/Postman itself already indent it) so diffs are human-readable instead of one giant minified line.

### Syncing Postman ↔ Git Automatically

Options, from simplest to most automated:
1. **Manual**: export after each change, commit manually — fine for small/solo projects.
2. **Postman API script**: a small Node.js/Python script using the [Postman API](03-postman-api.md) to pull the latest collection JSON and commit it on a schedule or via a git pre-commit/CI job.
3. **Postman's native Git/GitHub/GitLab integration** (available on some plans) — configure a workspace to auto-sync collections to a specified Git repo/branch on every save, removing the manual export step entirely.

## Code Review Workflow Example

```
1. Developer forks "Orders API" collection → makes changes → exports → opens a Git PR with the updated collection.json
2. Reviewer reads the PR diff: new request added, new test assertions, a variable renamed
3. CI runs Newman against the PR's collection automatically (Module 7.4)
4. On merge, a scheduled job re-imports the merged collection.json back into the canonical Postman team workspace (keeping Postman and Git the same "source of truth")
```

## Practice Exercise

1. Export your practice collection + environment into a local folder matching the layout above.
2. Initialize a git repo there (or use this repo's `12-hands-on-project/` folder) and make an initial commit.
3. Change one test assertion in Postman, re-export, and `git diff` the result — identify exactly which lines changed vs. which are just incidental ID/ordering noise.

Continue to → [10.3 The Postman API](03-postman-api.md)

# 10.4 Integrations

Postman connects into the broader toolchain so API testing isn't an isolated activity.

## Source Control Integrations

- **GitHub / GitLab / Bitbucket** — link a workspace to a repo for native sync of collections as code (available on applicable plans), so Postman changes can trigger/reflect in your actual Git history without manual export/import.

## CI/CD Integrations

- **GitHub Actions, GitLab CI, Jenkins, Azure DevOps, CircleCI, Travis CI** — all integrate via **Newman** (Module 7.3/7.4) since Newman is just a standard CLI/Node package any CI system can invoke. There isn't a "special" plugin required for most — just `npm install -g newman` and run it as a build step.

## Chat/Notification Integrations

- **Slack / Microsoft Teams** — configure Monitors or workspace activity to post alerts (e.g., "Monitor X failed", "Collection Y was updated") directly into a channel.
- **Email** — built-in for Monitor failure alerts regardless of other integrations.

## Issue Tracking Integrations

- **Jira** — link failing Monitor runs or collection comments to Jira tickets for tracking bug follow-up without leaving the workflow.

## API Gateway / Design Tool Integrations

- **OpenAPI/Swagger import** — generate a full collection directly from an OpenAPI spec (Module 6.2) — the most common "bring external API definitions into Postman" integration.
- **AsyncAPI** — similar concept for event-driven/async API specs.

## Browser Integrations

- **Postman Interceptor** (Chrome extension) — capture requests/cookies directly from browser traffic into Postman's History (Module 2.5).
- **Postman Desktop Agent** — required when using Postman Web to reach `localhost` or bypass certain CORS constraints, since the browser-hosted version can't do this natively.

## IDE Integrations

- **VS Code extension** — browse/run Postman collections directly inside VS Code without switching to the full app, handy for developers who want API testing alongside their code editor.

## Webhooks

- Postman workspaces can emit webhooks on certain events (collection changes, monitor failures) for custom integrations not covered by a built-in connector — point them at your own internal automation endpoint.

## Choosing What to Integrate (Practical Guidance)

| If your priority is... | Set up... |
|---|---|
| Catching broken builds automatically | CI/CD + Newman (Module 7.4) |
| Keeping Git as the source of truth | Git integration or scripted Postman API sync |
| Getting paged when production breaks | Monitors + Slack/Email alerts |
| Letting external consumers explore your API | OpenAPI import + Published Documentation (Module 6.3) |
| Developer convenience during coding | VS Code extension + Interceptor |

---
This completes Module 10. Continue to → [Module 11: Postman Flows](../11-postman-flows/01-flows-intro.md)

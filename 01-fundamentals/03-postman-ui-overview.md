# 1.3 Postman UI Overview

Understanding the layout up front will make every later module click faster.

## Main Layout Regions

```
┌─────────────────────────────────────────────────────────────────┐
│  Top Bar: Workspace switcher | Search | New | Invite | Settings  │
├───────────┬───────────────────────────────────────────────────────┤
│           │  Tabs (open requests)                                 │
│  Sidebar  ├───────────────────────────────────────────────────────┤
│  - Collections │ Request Builder                                  │
│  - APIs        │  Method + URL + Send button                      │
│  - Environments│  Params / Authorization / Headers / Body / etc.  │
│  - History     ├───────────────────────────────────────────────────┤
│  - Flows       │ Response Viewer                                   │
│  - Mock Servers│  Body / Cookies / Headers / Test Results          │
│  - Monitors    │                                                   │
└───────────┴───────────────────────────────────────────────────────┘
```

## 1. Sidebar (Left Panel)

- **Collections** — all your saved requests, organized in folders.
- **APIs** — if you're using Postman's API-definition features (OpenAPI/schema-first design).
- **Environments** — manage variable sets (Dev, Staging, Prod, etc.).
- **History** — every request you've ever sent (searchable), even if not saved to a collection. Lifesaver for recovering "that request I sent yesterday but forgot to save."
- **Flows** — visual, no-code workflow builder (Module 11).
- **Mock Servers / Monitors** — listed here if created.

## 2. Request Builder (Center)

- **Method dropdown** — GET, POST, PUT, PATCH, DELETE, HEAD, OPTIONS, plus GraphQL/custom.
- **URL bar** — supports variables, e.g. `{{baseUrl}}/users/{{userId}}`.
- **Tabs below the URL bar**:
  - **Params** — query string key/value editor (auto-syncs with the URL).
  - **Authorization** — pick an auth type (Module 04).
  - **Headers** — key/value editor for HTTP headers.
  - **Body** — none / form-data / x-www-form-urlencoded / raw (JSON, XML, text, JS, HTML) / binary / GraphQL (Module 02).
  - **Pre-request Script** — JS that runs before the request is sent (Module 05).
  - **Tests** — JS that runs after the response arrives (Module 05).
  - **Settings** — per-request overrides like SSL verification, redirects, encoding.

## 3. Response Viewer (Bottom/Right, after clicking Send)

- **Body** — Pretty / Raw / Preview tabs; auto-detects JSON/HTML/XML and syntax-highlights.
- **Cookies** — cookies set by the response.
- **Headers** — response headers.
- **Test Results** — pass/fail output of any `pm.test()` assertions, with counts.
- Status line shows **status code, response time, and response size** — useful at a glance for performance checks.

## 4. The "Save" Workflow

Every request you build is *unsaved* (a "draft" tab) until you explicitly:
1. Click **Save** (or `Cmd/Ctrl + S`)
2. Choose a **Collection** (and optionally a folder) to save it into
3. Give the request a descriptive name

> 🔑 **Best practice**: Save early. Unsaved requests live only in History and can be harder to find later, especially once you have dozens of them.

## 5. Workspaces Switcher (Top Left)

Lets you move between:
- **My Workspace** (personal, private by default)
- **Team workspaces** you belong to
- Any **Public workspaces** you've starred

Each workspace has its own collections, environments, and mock servers — think of it as a project container.

## 6. The Console (Debugging Tool)

**View → Show Postman Console** (or `Cmd/Ctrl + Alt + C`) opens a DevTools-style console showing:
- The *exact* raw request Postman sent (including headers Postman adds automatically, like `User-Agent`)
- The raw response
- `console.log()` output from your pre-request/test scripts

> This is your #1 debugging tool when "the request isn't doing what I expect."

## 7. Keyboard Shortcuts Worth Memorizing

| Shortcut (Win/Linux) | Shortcut (Mac) | Action |
|---|---|---|
| `Ctrl+S` | `Cmd+S` | Save request |
| `Ctrl+Enter` | `Cmd+Enter` | Send request |
| `Ctrl+Alt+C` | `Cmd+Alt+C` | Open Console |
| `Ctrl+N` | `Cmd+N` | New request/tab |
| `Ctrl+Click` env icon | — | Quickly view active environment's variables |
| `Ctrl+Alt+E` | `Cmd+Alt+E` | Open environment quick-look |

Continue to → [1.4 HTTP Fundamentals](04-http-fundamentals.md)

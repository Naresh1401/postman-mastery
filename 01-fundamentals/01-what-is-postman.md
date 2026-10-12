# 1.1 What is Postman?

## Overview

**Postman** is an API platform for building, testing, documenting, monitoring, and collaborating on APIs. It started in 2012 as a simple Chrome extension to make it easier to test REST APIs without writing `curl` commands, and has since grown into a full API lifecycle platform used by millions of developers and QA engineers.

## Why Postman Exists

Before Postman, testing an API meant either:
- Writing raw `curl` commands in a terminal, or
- Writing throwaway scripts in a programming language just to hit an endpoint.

Both approaches are slow, error-prone, and hard to share with teammates. Postman solves this by giving you a **GUI client** for making HTTP(S) requests, saving them, organizing them, and automating them — without writing boilerplate code.

## Core Capabilities

| Capability | What it does |
|---|---|
| **API Client** | Send REST, GraphQL, SOAP, WebSocket, gRPC, MQTT requests through a GUI |
| **Collections** | Group and organize related requests like a folder/test-suite |
| **Environments & Variables** | Reuse values (URLs, tokens, IDs) across requests and environments (dev/stage/prod) |
| **Scripting (Sandbox)** | Run JavaScript before/after a request to set up data, chain requests, or assert responses |
| **Automation (Collection Runner / Newman)** | Run entire collections repeatedly, with data files, for regression or data-driven testing |
| **Mock Servers** | Simulate an API before the real backend exists |
| **Monitors** | Schedule collections to run periodically to check uptime/health |
| **Documentation** | Auto-generate and publish human-readable API docs from a collection |
| **Collaboration** | Team workspaces, comments, version history, forking/merging collections |
| **Postman API & CLI (Newman)** | Automate Postman itself — manage collections/environments programmatically, run in CI/CD |

## Who Uses Postman and Why

- **Backend developers** — quickly exercise endpoints while building them.
- **QA/SDET engineers** — write functional, regression, and contract tests without a full framework.
- **Frontend developers** — understand API contracts before integrating.
- **DevOps engineers** — run API health checks and smoke tests in CI/CD pipelines.
- **Technical writers** — generate and publish API documentation.

## Postman vs Alternatives

| Tool | Key difference |
|---|---|
| `curl` / `httpie` | Command-line only, no built-in collection/environment management or GUI |
| Insomnia | Similar GUI client, smaller ecosystem, less enterprise tooling |
| SoapUI | Heavier, historically SOAP-focused, steeper learning curve |
| Swagger/OpenAPI tools (Swagger UI) | Primarily for documentation/spec-driven design, not as strong for ad-hoc testing & automation |
| REST Assured / Supertest (code-based) | Code-first testing frameworks — more powerful for CI-native test suites but require programming |

Postman's strength is the **balance**: a visual, no-code-required entry point that still scales up to full scripting, automation, and CI/CD.

## The Postman Ecosystem

1. **Postman Desktop App** — the main client (Windows/Mac/Linux). *Recommended over the deprecated Chrome app.*
2. **Postman Web** — browser-based version, syncs with your account.
3. **Newman** — Node.js command-line Collection Runner for CI/CD.
4. **Postman CLI** — native CLI bundled with the desktop app (`postman` command) as a lighter alternative to Newman.
5. **Postman API** — REST API to manage your Postman account/collections programmatically.
6. **Browser Extensions (Postman Interceptor / Agent)** — capture cookies and requests directly from the browser, bypass CORS for local testing.

## Key Terminology You'll See Throughout This Guide

- **Request** — a single HTTP call (method + URL + headers + body, etc.)
- **Collection** — a saved, organized group of requests (can be nested in folders)
- **Environment** — a named set of variables (e.g., `Dev`, `Staging`, `Prod`)
- **Workspace** — a container for collections/environments/APIs, used for organization and collaboration (Personal, Team, Private, Public, Partner)
- **Variable** — a reusable placeholder (`{{baseUrl}}`) resolved from one of several scopes
- **Script** — JavaScript code that runs before (`pre-request`) or after (`test`) a request
- **Runner** — the engine that executes a collection (manually via GUI Runner, or headlessly via Newman)
- **Monitor** — a scheduled, automated run of a collection (for uptime/health checks)
- **Mock Server** — a server that returns example responses defined in a collection without hitting a real backend

Continue to → [1.2 Installation and Setup](02-installation-and-setup.md)

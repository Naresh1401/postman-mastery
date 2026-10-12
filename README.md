# 📮 Postman Mastery — Complete End-to-End Study Guide

A **from-scratch, zero-to-advanced** guide to Postman — covering the GUI, HTTP fundamentals, scripting, authorization, environments, automation (Newman/CI-CD), mocking, monitoring, collaboration, advanced protocols (GraphQL/WebSocket/gRPC/MQTT), and a full hands-on project you can run today.

This repo is designed to be read **top to bottom** as a course, but every folder also stands alone as a reference you can jump back to.

## 🗺️ Learning Path

| # | Module | What you'll learn |
|---|--------|--------------------|
| 01 | [Fundamentals](01-fundamentals/) | What Postman is, installation, UI tour, HTTP basics |
| 02 | [Building Requests](02-building-requests/) | Methods, params, headers, body types, responses, cookies |
| 03 | [Variables & Environments](03-variables-and-environments/) | Variable scopes, environments, dynamic variables, Vault |
| 04 | [Authorization](04-authorization/) | Basic, Digest, NTLM, API Key, Bearer, OAuth 1.0/2.0, AWS Sig, Hawk |
| 05 | [Scripting](05-scripting/) | Pre-request scripts, test scripts, `pm` API, chaining requests, visualizer |
| 06 | [Collections & Organization](06-collections-and-organization/) | Folders, collection settings, docs generation, naming conventions |
| 07 | [Running & Automation](07-running-and-automation/) | Collection Runner, data-driven testing, Newman, CI/CD, Monitors |
| 08 | [Mocking & Monitoring](08-mocking-and-monitoring/) | Mock servers, monitors, uptime checks |
| 09 | [Advanced Protocols](09-advanced-protocols/) | GraphQL, WebSocket/Socket.IO, gRPC, MQTT/SOAP |
| 10 | [Collaboration & Workspaces](10-collaboration-and-workspaces/) | Team workspaces, Git-based version control, Postman API, integrations |
| 11 | [Postman Flows](11-postman-flows/) | Visual, no-code API workflow builder |
| 12 | [Hands-On Project](12-hands-on-project/) | A real, runnable collection + environments + Newman + GitHub Actions CI |
| 13 | [Cheatsheet & Interview Prep](13-cheatsheet-and-interview-prep/) | Quick reference, interview Q&A, troubleshooting guide |

## ✅ How to Use This Repo

1. **Read sequentially** if you're new — each module builds on the last.
2. **Install Postman** using [01-fundamentals/02-installation-and-setup.md](01-fundamentals/02-installation-and-setup.md) before module 02.
3. **Import the hands-on project** (module 12) into Postman to practice everything live:
   - Collection: `12-hands-on-project/collections/PostmanMastery.postman_collection.json`
   - Environments: `12-hands-on-project/environments/*.postman_environment.json`
4. **Run it headlessly** with Newman + the included GitHub Actions workflow (`.github/workflows/newman-ci.yml`) to see real CI/CD in action.
5. Use module 13 as a quick-reference cheat sheet before interviews or daily work.

## 🧰 Prerequisites

- No prior API testing experience required.
- Basic familiarity with HTTP (helpful, but covered from scratch in [01-fundamentals/04-http-fundamentals.md](01-fundamentals/04-http-fundamentals.md)).
- Node.js installed if you want to run Newman locally (module 07).

## 📦 What's Inside at a Glance

- 35+ in-depth markdown guides
- A fully working, importable Postman collection with pre-request scripts, tests, and chained requests
- Dev/Prod environment files
- CSV data file for data-driven testing
- Newman run script
- A ready-to-use GitHub Actions CI pipeline that runs the collection on every push

## 📄 License

MIT — see [LICENSE](LICENSE). Use freely for learning, teaching, or internal onboarding.

---
*Built as a complete, self-contained reference — no external course required.*

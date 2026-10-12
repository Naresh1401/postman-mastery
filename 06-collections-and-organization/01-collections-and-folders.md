# 6.1 Collections and Folders

## What a Collection Is

A **Collection** is the primary unit of organization in Postman — a named group of saved requests (optionally nested in folders) that can be:
- Run together (Collection Runner / Newman)
- Shared with teammates
- Exported/imported as a single JSON file
- Documented and published
- Version-controlled (history, forking)

## Creating a Collection

1. Sidebar → Collections → **+ Create Collection** (or **New → Collection**).
2. Name it descriptively (e.g., `User Service API Tests`, not `My Collection`).
3. Add requests via **Save As** from any request builder tab, or **Add Request** directly in the collection.

## Folders — Organizing Within a Collection

Folders let you group related requests (and even nest sub-folders):
```
User Service API Tests (Collection)
├── Auth
│   ├── Login
│   └── Refresh Token
├── Users
│   ├── Create User
│   ├── Get User
│   ├── Update User
│   └── Delete User
└── Orders
    ├── Create Order
    └── Get Order Status
```

### Why Use Folders
- **Logical grouping** by resource/feature, mirroring your API's structure.
- **Shared auth/scripts at the folder level** — e.g., all `Orders` requests inherit a folder-level pre-request script that checks inventory state.
- **Partial runs** — run just the `Users` folder via Collection Runner instead of the entire collection.
- **Folder-level Pre-request/Tests scripts** run for every request inside, in addition to collection-level and request-level scripts (see execution order in [5.1](../05-scripting/01-pre-request-scripts.md)).

## Reordering and Organizing

- Drag-and-drop requests/folders in the sidebar to reorder — **order matters** for Collection Runner/Newman execution (top to bottom) unless you use `setNextRequest`.
- Right-click → **Duplicate** to clone a request as a starting point for a variant.

## Collection-Level Features (Right-click Collection → Edit)

| Tab | Purpose |
|---|---|
| **Info** | Name, description (Markdown supported — this becomes your published docs' intro) |
| **Authorization** | Set auth once, inherited by all folders/requests |
| **Variables** | Collection-scoped variables |
| **Pre-request Script** | Runs before every request in the collection |
| **Tests** | Runs after every request in the collection |

## Adding Examples

Each request can have one or more **saved example responses** (Save Response → "Save as Example"). These:
- Appear nested under the request in the sidebar.
- Power generated documentation (showing "here's what a real response looks like").
- Can back a **Mock Server** (Module 08) without any real backend.

## Forking and Merging (Team Collaboration)

In a team workspace, you can **Fork** a collection to make changes in isolation, then **Create Pull Request** (Postman's own PR-like review flow) to merge changes back into the source collection — mirroring a Git workflow but native to Postman (see [Module 10](../10-collaboration-and-workspaces/)).

## Practice Exercise

1. Create a collection `Practice - Postman Echo`.
2. Create folders `Basics`, `Auth`, `Chaining`.
3. Move the requests you built in Modules 02–05 into the appropriate folders.
4. Set a collection-level variable `baseUrl = https://postman-echo.com` and update all requests to use `{{baseUrl}}` instead of the hardcoded domain.

Continue to → [6.2 Collection-Level Settings](02-collection-level-settings.md)

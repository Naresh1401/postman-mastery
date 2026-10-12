# 6.2 Collection-Level Settings

## Export / Import

### Export
Right-click Collection → **Export** → choose format:
- **Collection v2.1** (current standard format — always prefer this unless a legacy tool requires v1).

The exported `.postman_collection.json` is a plain JSON file you can:
- Commit to a Git repo (version control for your API tests — see [12-hands-on-project](../12-hands-on-project/)).
- Share via email/Slack for teammates without Postman cloud access.
- Feed directly into **Newman** for CI/CD.

### Import
**File → Import** → drag a `.json` file, paste raw text, paste a URL, or point at a folder/Git repo. Postman also auto-imports from:
- OpenAPI/Swagger spec files (`.yaml`/`.json`) — auto-generates a full collection with example requests from the spec.
- `curl` commands (paste a raw `curl ...` command and Postman converts it into a request).
- RAML, WADL (legacy support).

## Collection Versioning & History

- Team workspaces keep a **version history** of collection changes (who changed what, when) — accessible via the clock icon.
- You can **restore** a previous version if someone breaks something.

## Collection Settings Tab (gear icon within collection edit view)

| Setting | Effect |
|---|---|
| SSL certificate verification | Per-collection override of the global setting |
| Follow redirects | Whether 3xx responses are auto-followed |
| Encode URL automatically | Auto-percent-encode special characters in the URL |
| Disable cookie jar | Per-collection cookie handling override |

## Collection Description (Markdown)

The **Info → Description** field supports full Markdown — use it to document:
- What the collection tests/covers
- Prerequisites (which environment to select, required variables)
- Known limitations/edge cases not covered

This description becomes the landing page when you **Publish Documentation** (Module 6.3).

## Collection-Level Variables vs Environment Variables — When to Use Which

| Use a **Collection Variable** when... | Use an **Environment Variable** when... |
|---|---|
| The value never changes between Dev/Stage/Prod (e.g., a fixed API path segment, a constant like `apiVersion=v2`) | The value differs per deployment stage (`baseUrl`, `apiKey`) |
| You want the value bundled *with* the collection on export/share | You want to swap configs without touching the collection itself |

## Deleting / Archiving

- **Delete** a collection: right-click → Delete (irreversible in Free plan beyond the trash/recycle bin retention window — check **Workspace → Trash** to recover recently deleted items).
- Large unused collections should be archived (exported + removed) rather than left cluttering a shared team workspace.

## Practice Exercise

1. Export your `Practice - Postman Echo` collection as **Collection v2.1**.
2. Open the exported `.json` in a text editor — identify where `baseUrl` is stored, and locate the `event` array that holds your pre-request/test scripts.
3. Delete the collection from Postman, then re-import the exported file to confirm it restores fully intact.

Continue to → [6.3 Documentation Generation](03-documentation-generation.md)

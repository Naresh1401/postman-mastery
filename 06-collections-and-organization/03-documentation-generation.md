# 6.3 Documentation Generation

## Why This Matters

A well-organized collection **is already 80% of an API reference document** — Postman can auto-generate human-readable docs directly from it, with zero extra writing beyond good naming and descriptions.

## Generating Docs

1. Select a Collection → click **View Documentation** (book icon) or **"..." → View Documentation**.
2. Postman renders a formatted page showing:
   - The collection description (Markdown, rendered)
   - Every folder/request, organized in the same tree structure
   - For each request: method, URL, headers, body, and **saved example responses**
   - Auto-generated **code snippets** in 15+ languages (curl, Python, JS/fetch, Node/axios, Java, Go, Ruby, PHP, C#, etc.) for every request

## Making Docs Actually Useful

Good auto-generated docs depend entirely on what you put into the collection:
- **Request descriptions**: click a request → Documentation panel (right side) → write what the endpoint does, required params, auth needed.
- **Param/header descriptions**: each row in Params/Headers has a Description column — fill these in.
- **Saved example responses**: add at least one success example and one error example (e.g., a 404) per request so readers see real shapes, not just the schema.

## Publishing Documentation Publicly

1. From the Documentation view → **Publish** (or "..." menu → Publish Docs).
2. Choose visibility (public link vs. workspace-restricted).
3. Postman hosts a public URL like `https://documenter.getpostman.com/view/...` — shareable with external consumers of your API without requiring them to have a Postman account.
4. **Republish** after updates — published docs are a snapshot, not auto-synced; you must manually republish after changes.

## Embedding a "Run in Postman" Button

Published docs (and your own website/README) can include a **Run in Postman** button — a one-click import link for the collection, generated from: **Collection "..." menu → Share → "Via Run in Postman Button"**. This gives it an embeddable `<a>`/markdown snippet readers click to instantly import the whole collection + environment into their own Postman.

## Keeping Docs in Sync with Reality

- Treat the collection itself as the **source of truth** — update requests/tests first, then regenerate/republish docs, not the other way around.
- For teams practicing "docs as code," commit the exported collection JSON to Git (Module 10.2) so documentation changes go through the same PR review as code changes.

## Practice Exercise

1. Add a description to your `Practice - Postman Echo` collection summarizing its purpose.
2. Add a one-sentence description to at least 2 requests.
3. Click **View Documentation** and review the generated page.
4. Generate a **code snippet** for one request in 2 different languages (e.g., `curl` and `Python - Requests`) via the `</>` icon next to the Send button.

Continue to → [6.4 Best Practices and Naming Conventions](04-best-practices-naming.md)

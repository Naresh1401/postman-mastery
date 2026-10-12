# 10.3 The Postman API

## What It Is

The **Postman API** is a REST API that lets you manage your Postman account programmatically — collections, environments, workspaces, mock servers, monitors — entirely outside the GUI. Meta, but extremely useful for automation (e.g., syncing to Git, bulk updates, generating collections from an external source of truth).

## Authentication

Every call requires an **API Key**, generated from: Postman → Account Settings → **API Keys** → Generate Key.

```bash
curl --location 'https://api.getpostman.com/collections' \
  --header 'X-Api-Key: {{postmanApiKey}}'
```
Or as a query param: `?apikey=<key>` (header method is preferred/more secure — avoid query params landing in logs).

## Common Operations

### List All Collections
```bash
GET https://api.getpostman.com/collections
```

### Get a Single Collection's Full JSON
```bash
GET https://api.getpostman.com/collections/{collection_uid}
```

### Create/Update a Collection
```bash
PUT https://api.getpostman.com/collections/{collection_uid}
Content-Type: application/json

{ "collection": { ...full collection v2.1 JSON... } }
```

### List Environments
```bash
GET https://api.getpostman.com/environments
```

### Update an Environment Variable Programmatically
```bash
PUT https://api.getpostman.com/environments/{environment_uid}
Content-Type: application/json

{
  "environment": {
    "name": "Dev",
    "values": [
      { "key": "baseUrl", "value": "https://new-dev-url.example.com", "enabled": true }
    ]
  }
}
```

### Trigger a Monitor Run On-Demand
```bash
POST https://api.getpostman.com/monitors/{monitor_uid}/run
```

### Create a Mock Server
```bash
POST https://api.getpostman.com/mocks
```

## Practical Automation Examples

### 1. Sync Postman Collection → Git Repo (Node.js script)
```js
const fetch = require('node-fetch');
const fs = require('fs');

async function syncCollection() {
    const res = await fetch('https://api.getpostman.com/collections/MY_COLLECTION_UID', {
        headers: { 'X-Api-Key': process.env.POSTMAN_API_KEY }
    });
    const data = await res.json();
    fs.writeFileSync(
        './collections/MyAPI.postman_collection.json',
        JSON.stringify(data.collection, null, 2)
    );
}
syncCollection();
```
Run this on a schedule (cron / CI job) to keep a Git repo automatically mirroring the canonical Postman collection.

### 2. Bulk-Update an Environment Variable Across Many Environments
Useful when a shared value (e.g., a rotated API key, a new base domain) needs to change everywhere at once instead of manually editing each environment in the UI.

### 3. Programmatically Spin Up a Mock Server per Feature Branch (CI)
A CI pipeline can create a fresh, isolated mock server for each PR/feature branch, run frontend integration tests against it, then delete it on PR close — all via API calls, no manual Postman UI steps.

## Rate Limits

The Postman API enforces rate limits per API key (check the `X-RateLimit-Limit` / `X-RateLimit-Remaining` response headers) — design sync scripts to run periodically, not in a tight loop.

## Practice Exercise

1. Generate a Postman API key.
2. `GET https://api.getpostman.com/collections` with that key as `X-Api-Key` header — confirm you see your practice collection listed.
3. `GET` its full JSON via the UID from step 2 and compare it to a manual export — confirm they match.

Continue to → [10.4 Integrations](04-integrations.md)

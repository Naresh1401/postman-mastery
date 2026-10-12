# 1.2 Installation and Setup

## Option A: Desktop App (Recommended)

The desktop app is the most feature-complete and stable way to use Postman (supports system proxy settings, native cert handling, Interceptor extension, etc.).

1. Go to https://www.postman.com/downloads/
2. Download the installer for your OS:
   - **Windows** — `.exe` installer
   - **macOS** — `.zip` (Intel or Apple Silicon build)
   - **Linux** — `.tar.gz`, Snap, or `.deb`/`.rpm` depending on distro
3. Install and launch the app.
4. **Sign up / Log in** (free account) — a free Postman account unlocks sync, cloud workspaces, and collaboration features. You *can* use Postman fully offline in "Lightweight API Client" mode without an account, but you lose sync and team features.

### macOS via Homebrew
```bash
brew install --cask postman
```

### Linux via Snap
```bash
sudo snap install postman
```

## Option B: Web Version

Go to https://go.postman.co/ and use Postman directly in the browser. Requires the **Postman Agent** (a small local helper app) to send requests that hit `localhost` or have strict CORS, since browsers can't do everything a native app can.

## Option C: Postman CLI (no GUI)

Postman also ships a native CLI (separate from Newman) for running collections headlessly:
```bash
# Installed automatically with the desktop app, or standalone:
curl -o- "https://dl-cli.pstmn.io/install/osx.sh" | sh
postman login --with-api-key <YOUR_API_KEY>
postman collection run <collection-id-or-path>
```

## First-Time Setup Checklist

1. **Create/opt into a free account** — Settings → Sign in. This enables:
   - Cloud sync of collections/environments across devices
   - Team workspaces
   - Collection version history
2. **Choose a Workspace** — by default you land in "My Workspace" (personal). You can create additional workspaces later (see [Module 10](../10-collaboration-and-workspaces/01-workspaces-teams.md)).
3. **Install the Postman Interceptor extension** (optional) — needed for:
   - Capturing requests directly from Chrome
   - Syncing browser cookies into Postman for cookie-based auth testing
   - Bypassing some CORS restrictions when using Postman Web
4. **Configure SSL certificate verification** — Settings → General → turn OFF "SSL certificate verification" only for local/dev testing against self-signed certs. Keep it ON for production testing.
5. **Set a request timeout and proxy (if needed)** — Settings → General / Proxy, especially relevant behind corporate networks.
6. **Enable/disable the "Postman Desktop Agent"** if you plan to use Postman Web but need native request capabilities (localhost calls, client certs).

## Verifying Your Install

Create a quick sanity-check request:
1. Click **New → HTTP Request**.
2. Set method to `GET`, URL to `https://postman-echo.com/get?foo=bar`.
3. Click **Send**.
4. You should get a `200 OK` with a JSON body echoing your query param.

> `postman-echo.com` is a public service maintained by Postman specifically for learning/testing — we'll use it throughout this guide instead of a random third-party API.

## Updating Postman

Postman auto-updates by default. To check manually: **Help → Check for Updates** (or **Postman → Check for Updates** on macOS).

## Uninstalling / Resetting

- **macOS**: delete the app from `/Applications`, then remove `~/Library/Application Support/Postman` to fully reset local data (collections not synced to cloud will be lost — export first!).
- **Windows**: Control Panel → Uninstall, then clear `%APPDATA%\Postman`.
- **Linux**: remove the Snap/package, then clear `~/.config/Postman`.

Continue to → [1.3 Postman UI Overview](03-postman-ui-overview.md)

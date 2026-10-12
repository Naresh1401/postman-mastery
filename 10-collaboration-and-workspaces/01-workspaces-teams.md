# 10.1 Workspaces and Teams

## Types of Workspaces

| Type | Visibility | Use case |
|---|---|---|
| **Personal** ("My Workspace") | Only you | Individual learning, scratch work, private experiments |
| **Team** | Members of your Postman team | Day-to-day collaborative API development (most common in a company) |
| **Private** | Invite-only, explicit members | Sensitive projects within an org that shouldn't be team-wide by default |
| **Public** | Anyone with the link, even without a Postman account | Open-source projects, public API documentation/examples |
| **Partner** | You + explicitly invited external orgs | Cross-company API collaboration (e.g., with a vendor or integration partner) |

## Creating a Team Workspace

1. Top bar → Workspace switcher → **Create Workspace**.
2. Choose visibility type, name it, add a description.
3. **Invite members** by email — assign roles.

## Roles and Permissions (Team Workspace)

| Role | Typical permissions |
|---|---|
| **Admin** | Full control: manage members, billing, delete workspace |
| **Editor** | Create/edit collections, environments, mock servers, monitors |
| **Viewer** | Read-only access — can view and run, but not modify |

Exact role names/granularity vary by Postman plan tier (Free/Basic/Team/Enterprise), but the Admin/Editor/Viewer concept is consistent.

## Why Workspaces Matter Beyond "Just Folders"

- Each workspace has its **own** collections, environments, mock servers, monitors — a clean project boundary.
- **Activity Feed** per workspace shows who changed what and when — audit trail for collaborative editing.
- **Comments** can be left directly on a request/collection for async discussion without leaving Postman.

## Real-Time Collaboration

In a Team workspace, multiple people can have the **same collection open simultaneously** — Postman shows live presence indicators (avatars) and syncs changes in near real-time, similar to collaborative document editors.

## Moving/Copying Between Workspaces

- **Move**: right-click a collection → **Move** → pick a destination workspace (removes it from the source).
- **Copy/Fork**: keeps the original in place, creates an independent (or linked, if forked) copy elsewhere.

## Practice Exercise

1. Create a new **Team** workspace (or a second Personal workspace if you don't have teammates to invite) called `Postman Mastery Practice`.
2. Move your `Practice - Postman Echo` collection into it.
3. Explore the **Activity Feed** to see the log of that move action.

Continue to → [10.2 Version Control with Git](02-version-control-git.md)

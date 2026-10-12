# 11.1 Postman Flows

## What Flows Are

**Postman Flows** is a **visual, no-code/low-code** canvas for building multi-step API workflows by connecting blocks — instead of writing sequential pre-request/test scripts to chain requests (Module 5.4), you drag-and-drop nodes and wire their outputs to inputs.

## When to Use Flows vs. Scripted Chaining

| Use **Flows** when... | Use **scripted chaining** when... |
|---|---|
| You want a visual, shareable diagram of how requests connect (easy for non-coders to follow) | You need precise control, complex conditional logic, or heavy data manipulation best expressed in code |
| Prototyping a workflow quickly without writing JS | The logic is already well-established and lives in a mature collection |
| Demoing an integration's data flow to stakeholders | Performance-sensitive runs where visual-canvas overhead isn't worth it |

They're not mutually exclusive — a Flow can include a **Send Request** block that calls a request whose own Tests script still does scripted assertions/chaining internally.

## Core Building Blocks (Nodes)

| Block | Purpose |
|---|---|
| **Start** | Entry point of the Flow |
| **Send Request** | Fire an existing collection request |
| **Evaluate** | Run custom JavaScript inline (same sandbox as pre-request/test scripts) |
| **If/Condition** | Branch logic based on a value |
| **For Loop / Repeat** | Iterate over a list or run N times |
| **Variables / Data** | Read/write environment/collection/global variables |
| **Delay** | Pause execution for a set time |
| **Output/Log** | Display a value in the Flow's output panel for inspection |

## Example Flow: "Create Order, Then Poll Until Shipped"

```
[Start] → [Send Request: Create Order]
             → [Evaluate: extract orderId]
                   → [For Loop: repeat until "shipped"]
                         → [Send Request: Get Order Status]
                         → [If status == "shipped" → exit loop]
                         → [Delay: 2s]
                   → [Send Request: Notify Customer]
```
This visually represents the exact polling pattern described in [5.4](../05-scripting/04-chaining-requests.md), but as a diagram instead of nested `setNextRequest` calls.

## Creating a Flow

1. Sidebar → **Flows** → **Create Flow**.
2. Drag a **Start** block onto the canvas.
3. Drag a **Send Request** block, select an existing request from your collection.
4. Connect blocks by dragging from one block's output handle to the next block's input handle.
5. Click **Run** to execute the whole Flow and watch data move through each connection live, with inspectable values at every step.

## Debugging a Flow

- Click any block **after a run** to see exactly what data flowed in/out of it — far more visual than scrolling through `console.log()` output in a traditional script.
- Use an **Output** block at key points to deliberately surface intermediate values for inspection.

## Limitations

- Best suited for **moderate complexity** workflows — extremely intricate branching logic can become harder to read as a sprawling diagram than as well-organized code.
- Flows execute within Postman's app context — for unattended/CI execution of the *same* logic, you'd typically still fall back to a scripted collection + Newman (Flows themselves are primarily an in-app, interactive/demo tool as of this writing, not a CI runner target).

## Practice Exercise

1. Build a simple Flow: Start → Send Request (your `Create User` request from Module 05) → Evaluate (log the returned `id`) → Send Request (`Get User` using that id).
2. Run it and click through each block to inspect the data passed between them.

---
This completes Module 11. Continue to → [Module 12: Hands-On Project](../12-hands-on-project/)

# 5.5 The Visualizer

## What It Does

By default, API responses are just text/JSON in the response viewer. The **Visualizer** lets you render a response as custom **HTML** — tables, charts, formatted summaries — using a template + data you define in a Tests script.

## Basic Example

```js
// In the Tests tab
const template = `
<table style="width:100%; border-collapse: collapse;">
    <tr><th style="border:1px solid #ccc; padding:4px;">Name</th><th style="border:1px solid #ccc; padding:4px;">Email</th></tr>
    {{#each response}}
    <tr>
        <td style="border:1px solid #ccc; padding:4px;">{{this.name}}</td>
        <td style="border:1px solid #ccc; padding:4px;">{{this.email}}</td>
    </tr>
    {{/each}}
</table>
`;

pm.visualizer.set(template, { response: pm.response.json() });
```
After sending the request, click the **Visualize** tab in the response panel (alongside Pretty/Raw/Preview) to see the rendered table instead of raw JSON.

## Templating Engine

Postman's Visualizer uses **Handlebars.js** syntax:
- `{{variable}}` — output a value
- `{{#each array}} ... {{/each}}` — loop
- `{{#if condition}} ... {{/if}}` — conditional

## Example: Bar Chart with Chart.js (via CDN)

```js
const template = `
<canvas id="myChart" width="400" height="200"></canvas>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    const ctx = document.getElementById('myChart').getContext('2d');
    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: {{labels}},
            datasets: [{ label: 'Price', data: {{prices}} }]
        }
    });
</script>
`;

const json = pm.response.json();
pm.visualizer.set(template, {
    labels: JSON.stringify(json.map(p => p.name)),
    prices: JSON.stringify(json.map(p => p.price))
});
```

## Why It's Useful

- **Non-technical stakeholders**: show a demo of an API response as a readable dashboard instead of raw JSON.
- **Debugging large/nested payloads**: render only the fields you care about, formatted clearly.
- **Living documentation**: pair a saved example response with a Visualizer template to make a collection genuinely useful to read, not just run.

## Practice Exercise

1. `GET https://postman-echo.com/get?user=Ada&role=admin`
2. In Tests, set up a Visualizer template that renders the `args` object as an HTML definition list (`<dl>`).
3. Click **Visualize** in the response tab to confirm it renders.

---
This completes Module 05 — the heart of Postman's power. Continue to → [Module 06: Collections & Organization](../06-collections-and-organization/01-collections-and-folders.md)

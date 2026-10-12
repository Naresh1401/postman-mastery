# 13.1 Quick Reference Cheat Sheet

## Variable Scope Precedence (Highest → Lowest)
```
Local > Data > Environment > Collection > Global
```

## Common `pm` Snippets

```js
// Status code
pm.test("Status 200", () => pm.response.to.have.status(200));

// Response time
pm.test("Fast enough", () => pm.expect(pm.response.responseTime).to.be.below(500));

// JSON body value
pm.test("Has id", () => pm.expect(pm.response.json().id).to.exist);

// Set a variable from response
pm.environment.set("token", pm.response.json().access_token);

// Get with scope precedence
pm.variables.get("baseUrl");

// Dynamic header
pm.request.headers.add({ key: "X-Trace-Id", value: pm.variables.replaceIn("{{$guid}}") });

// Send an extra request
pm.sendRequest(url, (err, res) => console.log(res.json()));

// Control next request (Runner/Newman only)
pm.execution.setNextRequest("Request Name");
pm.execution.setNextRequest(null); // stop
```

## Dynamic Variables (Most Used)
```
{{$guid}}  {{$randomUUID}}  {{$timestamp}}  {{$isoTimestamp}}
{{$randomInt}}  {{$randomEmail}}  {{$randomFullName}}  {{$randomUserName}}
{{$randomBoolean}}  {{$randomPrice}}  {{$randomIP}}
```

## HTTP Status Codes Quick Reference
```
200 OK           201 Created        204 No Content
301/302 Redirect 304 Not Modified
400 Bad Request  401 Unauthorized   403 Forbidden   404 Not Found
409 Conflict     422 Unprocessable  429 Too Many Requests
500 Internal     502 Bad Gateway    503 Unavailable 504 Gateway Timeout
```
`401` = who are you? `403` = I know you, but no.

## Newman One-Liners
```bash
newman run collection.json
newman run collection.json -e env.json
newman run collection.json -e env.json -d data.csv
newman run collection.json -n 5 --delay-request 200
newman run collection.json -r cli,junit,htmlextra --reporter-junit-export r.xml --reporter-htmlextra-export r.html
newman run collection.json --env-var "baseUrl=https://staging.example.com"
newman run collection.json --bail
newman run collection.json --insecure
```

## Authorization Type Cheat Sheet

| Need | Type |
|---|---|
| username/password, simple | Basic Auth |
| hashed challenge/response | Digest Auth |
| Windows domain | NTLM |
| static key, header or query | API Key |
| JWT/token from login | Bearer Token |
| full login/consent flow | OAuth 2.0 (Authorization Code) |
| machine-to-machine | OAuth 2.0 (Client Credentials) |
| legacy signed requests | OAuth 1.0 |
| AWS service | AWS Signature |

## Body Type Cheat Sheet

| Need | Body type |
|---|---|
| Modern JSON API | raw → JSON |
| File + text fields | form-data |
| Raw file only | binary |
| Legacy HTML form | x-www-form-urlencoded |
| GraphQL | GraphQL |
| SOAP/XML | raw → XML |

## Keyboard Shortcuts

| Action | Win/Linux | Mac |
|---|---|---|
| Save | `Ctrl+S` | `Cmd+S` |
| Send | `Ctrl+Enter` | `Cmd+Enter` |
| Console | `Ctrl+Alt+C` | `Cmd+Alt+C` |
| New Tab | `Ctrl+N` | `Cmd+N` |
| Env Quick Look | `Ctrl+Alt+E` | `Cmd+Alt+E` |

## Export Checklist Before Sharing a Collection
- [ ] No real secrets in Initial Values
- [ ] Variables used instead of hardcoded URLs/tokens
- [ ] Descriptions added to collection + key requests
- [ ] At least one test assertion per request
- [ ] Collection v2.1 format selected on export

Continue to → [13.2 Interview Questions](02-interview-questions.md)

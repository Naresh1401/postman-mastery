# 4.5 AWS Signature, Hawk, and Other Auth Types

## AWS Signature (SigV4)

Used for calling AWS services directly (S3, API Gateway with IAM auth, DynamoDB, etc.) without the AWS SDK.

**How it works**: AWS requires every request to be signed with your Access Key + Secret Key, incorporating the HTTP method, canonicalized headers, payload hash, date, and target region/service — producing a `Authorization: AWS4-HMAC-SHA256 Credential=...` header.

**In Postman**:
1. Authorization tab → Type: **AWS Signature**.
2. Fill in:
   - **AccessKey** / **SecretKey** (use `{{variables}}`, ideally Vault-backed)
   - **AWS Region** (e.g., `us-east-1`)
   - **Service Name** (e.g., `s3`, `execute-api`, `dynamodb`)
   - **Session Token** (only if using temporary STS credentials)
3. Postman computes the full SigV4 signature automatically — no manual hashing required.

### Example: Listing an S3 Bucket
```
GET https://my-bucket.s3.amazonaws.com/?list-type=2
Authorization: AWS Signature
  AccessKey: {{awsAccessKey}}
  SecretKey: {{awsSecretKey}}
  Region: us-east-1
  Service Name: s3
```

## Hawk Authentication

An HMAC-based scheme (less common today, seen in some older Mozilla-ecosystem/Node.js APIs). Requires an **ID** and **Key**, and signs requests with a timestamp + nonce, similar in spirit to OAuth 1.0 but with a different wire format (`Authorization: Hawk id="...", ts="...", mac="..."`).

**In Postman**: Authorization tab → Type: **Hawk Authentication** → fill in Hawk Auth ID, Hawk Auth Key, Algorithm (`sha256` typically), and optional User/Ext/App/Dlg fields. Postman computes the MAC automatically.

## Akamai EdgeGrid

For Akamai's CDN/API management APIs — requires Client Token, Client Secret, Access Token, and optionally a Nonce/Timestamp override. Postman has a dedicated **Akamai EdgeGrid** auth type that signs requests per Akamai's spec.

## ASAP (Atlassian)

Used for Atlassian's internal service-to-service authentication — requires Issuer, Key ID, Audience, Private Key (PEM), and optional claims. Postman has a dedicated **ASAP** auth type under Authorization.

## Custom / Unsupported Auth Schemes

If an API uses a signing scheme Postman doesn't natively support (e.g., a bespoke HMAC scheme), implement it yourself in a **Pre-request Script**:

```js
// Example: custom HMAC-SHA256 signing in a pre-request script
const CryptoJS = require('crypto-js'); // Postman Sandbox bundles crypto-js
const secret = pm.environment.get("apiSecret");
const timestamp = Date.now().toString();
const method = pm.request.method;
const path = pm.request.url.getPath();
const bodyString = pm.request.body ? pm.request.body.raw : "";

const stringToSign = `${method}\n${path}\n${timestamp}\n${bodyString}`;
const signature = CryptoJS.HmacSHA256(stringToSign, secret).toString(CryptoJS.enc.Hex);

pm.request.headers.add({ key: "X-Timestamp", value: timestamp });
pm.request.headers.add({ key: "X-Signature", value: signature });
```
This pattern (compute in pre-request script, inject as a header) is the general escape hatch for **any** proprietary auth scheme.

## Summary Decision Table

| If the API uses... | Use Postman auth type |
|---|---|
| Username + password, simple | Basic Auth |
| Challenge/response hashed credentials | Digest Auth |
| Windows domain auth | NTLM |
| Static key in header/query | API Key |
| JWT / token from a login endpoint | Bearer Token |
| Full OAuth handshake (Google, GitHub, etc.) | OAuth 2.0 |
| Legacy signed-request API | OAuth 1.0 |
| AWS service | AWS Signature |
| Custom HMAC/proprietary scheme | Pre-request Script + manual headers |

---
This completes Module 04. Continue to → [Module 05: Scripting](../05-scripting/01-pre-request-scripts.md)

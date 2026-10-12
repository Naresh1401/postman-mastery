# 9.4 MQTT and SOAP

## MQTT

**MQTT** (Message Queuing Telemetry Transport) is a lightweight publish/subscribe messaging protocol, dominant in **IoT** (sensors, smart devices, telemetry pipelines) due to its low overhead.

### Creating an MQTT Request
1. **New → MQTT Request**.
2. Enter the broker URL (e.g., `mqtt://broker.hivemq.com:1883` or `mqtts://` for TLS).
3. Configure the **Connection** settings: Client ID, optional username/password, Keep Alive interval, Clean Session flag.
4. **Connect** to the broker.

### Publishing a Message
- Specify a **Topic** (e.g., `sensors/temperature/room1`) and a **Payload**.
- Click **Publish** — the broker routes it to any subscribers of that topic.

### Subscribing to a Topic
- Enter a topic pattern (supports wildcards: `+` for one level, `#` for multi-level, e.g., `sensors/+/room1` or `sensors/#`).
- Click **Subscribe** — incoming messages on matching topics appear in a live log pane, similar to the WebSocket message log.

### QoS Levels
| QoS | Guarantee |
|---|---|
| 0 | At most once (fire and forget) |
| 1 | At least once (may duplicate) |
| 2 | Exactly once (highest overhead) |

Set this per publish/subscribe action depending on the delivery guarantee your test needs.

### Practice Exercise
1. Connect to a public test broker like `mqtt://broker.hivemq.com:1883`.
2. Subscribe to a unique topic, e.g., `postman-mastery/test/yourname`.
3. In a second request (or the same connection's publish panel), publish a message to that same topic.
4. Confirm it appears in your subscription's message log.

---

## SOAP

**SOAP** (Simple Object Access Protocol) is an older, XML-based protocol still common in enterprise/legacy systems (banking, government, large ERP integrations). Unlike REST, SOAP has a strict envelope structure and is described by **WSDL** (Web Services Description Language) files.

### Postman Doesn't Have a Dedicated "SOAP Request Type" — It's Just HTTP + XML

SOAP calls are plain HTTP `POST` requests with:
- `Content-Type: text/xml; charset=utf-8` (SOAP 1.1) or `application/soap+xml` (SOAP 1.2)
- A `SOAPAction` header (SOAP 1.1) identifying the operation
- A **raw XML body** following the SOAP envelope structure

### Example SOAP Request

```
POST https://example.com/soap-service
Content-Type: text/xml; charset=utf-8
SOAPAction: "http://example.com/GetUserDetails"
```

Body (raw, XML):
```xml
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Header/>
  <soap:Body>
    <GetUserDetails xmlns="http://example.com/">
      <UserId>{{userId}}</UserId>
    </GetUserDetails>
  </soap:Body>
</soap:Envelope>
```

### Importing a WSDL

**File → Import** → point at a `.wsdl` file or URL. Postman parses it and **generates a collection** with one request per operation, pre-filled with a skeleton XML envelope matching each operation's expected input — saving you from hand-writing the envelope structure from scratch.

### Testing XML Responses

Since `pm.response.json()` won't work on XML, use `xml2js` (bundled in the Sandbox, see [5.3](../05-scripting/03-pm-api-reference.md)) to parse it:
```js
const xml2js = require('xml2js');
let parsedResponse;

xml2js.parseString(pm.response.text(), (err, result) => {
    parsedResponse = result;
});

pm.test("Response contains expected user name", function () {
    const name = parsedResponse["soap:Envelope"]["soap:Body"][0]
        .GetUserDetailsResponse[0].UserName[0];
    pm.expect(name).to.eql("Ada Lovelace");
});
```

### Practice Exercise
Find a public test SOAP service (e.g., a numeric/country-code SOAP demo service), import its WSDL into Postman, and invoke one of its generated requests, confirming the raw XML response structure in the Pretty view.

---
This completes Module 09. Continue to → [Module 10: Collaboration & Workspaces](../10-collaboration-and-workspaces/01-workspaces-teams.md)

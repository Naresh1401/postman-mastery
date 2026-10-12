# 7.4 CI/CD Integration

## Why This Matters

Running tests manually catches bugs **you remember to check for**. Running them automatically on every push/PR catches bugs **before they reach production**, every single time, with zero human reliance.

## GitHub Actions Example

This repo includes a working example at [`.github/workflows/newman-ci.yml`](../.github/workflows/newman-ci.yml). Key structure:

```yaml
name: API Tests (Newman)
on:
  push:
    branches: [main]
  pull_request:

jobs:
  run-postman-tests:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
      - run: npm install -g newman newman-reporter-htmlextra
      - run: |
          newman run 12-hands-on-project/collections/PostmanMastery.postman_collection.json \
            -e 12-hands-on-project/environments/dev.postman_environment.json \
            -r cli,junit,htmlextra \
            --reporter-junit-export newman-results.xml \
            --reporter-htmlextra-export newman-report.html
      - uses: actions/upload-artifact@v4
        if: always()
        with:
          name: newman-report
          path: |
            newman-results.xml
            newman-report.html
```

- `if: always()` on the upload step ensures the report is saved **even if tests failed** — critical for debugging CI failures.
- The job naturally **fails the build** if Newman's exit code is non-zero (any assertion failed), blocking a bad PR merge.

## GitLab CI Example

```yaml
api-tests:
  image: node:20
  stage: test
  script:
    - npm install -g newman newman-reporter-junit
    - newman run collection.json -e env.json -r cli,junit --reporter-junit-export report.xml
  artifacts:
    when: always
    reports:
      junit: report.xml
```

## Jenkins (Declarative Pipeline) Example

```groovy
pipeline {
    agent any
    stages {
        stage('API Tests') {
            steps {
                sh 'npm install -g newman newman-reporter-junit'
                sh 'newman run collection.json -e env.json -r cli,junit --reporter-junit-export report.xml'
            }
        }
    }
    post {
        always {
            junit 'report.xml'
        }
    }
}
```

## Azure DevOps Example

```yaml
steps:
  - task: NodeTool@0
    inputs:
      versionSpec: '20.x'
  - script: |
      npm install -g newman
      newman run collection.json -e env.json -r cli,junit --reporter-junit-export $(Build.ArtifactStagingDirectory)/report.xml
  - task: PublishTestResults@2
    inputs:
      testResultsFormat: 'JUnit'
      testResultsFiles: '$(Build.ArtifactStagingDirectory)/report.xml'
```

## Managing Secrets in CI (Never Hardcode Tokens in the Pipeline File)

- Store real API keys/tokens as **CI secret variables** (GitHub Actions Secrets, GitLab CI/CD Variables, Jenkins Credentials).
- Pass them to Newman via `--env-var` at run time, overriding a placeholder in the committed environment file:
```bash
newman run collection.json -e env.json --env-var "apiKey=$API_KEY_SECRET"
```
This way the committed `env.json` only ever contains an empty/placeholder value, and the real secret only exists in the CI runner's memory for that job.

## Failing the Build Intentionally on Specific Conditions

```bash
newman run collection.json --bail  # stop immediately on first failure
```
Or write a custom test asserting response time SLAs, so performance regressions also fail the build:
```js
pm.test("Response under 300ms SLA", function () {
    pm.expect(pm.response.responseTime).to.be.below(300);
});
```

## Monitoring Build Health Over Time

Upload the **htmlextra** or **junit** report as a build artifact every run (not just on failure) so you have a historical trail, and surface pass/fail trends in your CI dashboard or a tool like Allure if you want trend graphs across many runs.

## Practice Exercise

1. Review `.github/workflows/newman-ci.yml` in this repo.
2. Push this repo to GitHub (see the main [README](../README.md)) and confirm the Action runs automatically, uploading a report artifact.
3. Intentionally break a test assertion in the collection, push again, and confirm the workflow run shows as **failed** in the Actions tab.

Continue to → [7.5 Monitors](05-monitors.md)

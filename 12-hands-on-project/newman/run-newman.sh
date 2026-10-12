#!/usr/bin/env bash
#
# run-newman.sh
# Runs the Postman Mastery hands-on collection via Newman, generating
# CLI, JUnit, and HTML reports. Mirrors exactly what the CI workflow does
# (.github/workflows/newman-ci.yml), so you can reproduce CI failures locally.
#
# Usage:
#   ./run-newman.sh            # runs against the Dev environment
#   ./run-newman.sh prod       # runs against the Prod environment
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

ENV_NAME="${1:-dev}"
COLLECTION="$PROJECT_DIR/collections/PostmanMastery.postman_collection.json"
ENVIRONMENT="$PROJECT_DIR/environments/${ENV_NAME}.postman_environment.json"
DATA_FILE="$PROJECT_DIR/data/users.csv"
REPORT_DIR="$PROJECT_DIR/newman/reports"

if ! command -v newman &> /dev/null; then
    echo "Newman is not installed. Install it with: npm install -g newman newman-reporter-htmlextra"
    exit 1
fi

if [ ! -f "$ENVIRONMENT" ]; then
    echo "Environment file not found: $ENVIRONMENT"
    echo "Available environments:"
    ls "$PROJECT_DIR/environments"
    exit 1
fi

mkdir -p "$REPORT_DIR"

echo "Running collection against '$ENV_NAME' environment..."

newman run "$COLLECTION" \
    -e "$ENVIRONMENT" \
    -d "$DATA_FILE" \
    -r cli,junit,htmlextra \
    --reporter-junit-export "$REPORT_DIR/newman-results.xml" \
    --reporter-htmlextra-export "$REPORT_DIR/newman-report.html" \
    --reporter-htmlextra-darkTheme

echo ""
echo "Reports written to: $REPORT_DIR"
echo "  - JUnit XML: $REPORT_DIR/newman-results.xml"
echo "  - HTML:      $REPORT_DIR/newman-report.html"

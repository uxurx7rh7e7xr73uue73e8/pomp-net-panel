#!/usr/bin/env bash
set -e

echo "Checking Pomp Net Panel health..."
echo ""

PANEL_PORT="${XUI_PORT:-8080}"

if [ -n "${PORT:-}" ]; then
  PANEL_PORT="${PORT}"
fi

echo "Testing health endpoint on port ${PANEL_PORT}..."

if curl -fsS "http://127.0.0.1:${PANEL_PORT}/health" > /dev/null 2>&1; then
  echo "✓ Panel is healthy"
  exit 0
else
  echo "✗ Panel is not responding"
  exit 1
fi

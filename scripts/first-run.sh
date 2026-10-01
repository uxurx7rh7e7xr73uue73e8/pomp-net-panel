#!/usr/bin/env bash
set -eu

# First-run initialization for Pomp Net Panel
# Based on official MHSanaei/3x-ui

echo "Pomp Net Panel - First Run Setup"
echo "================================="

# Ensure data directory exists
DB_FOLDER="${XUI_DB_FOLDER:-/app/data}"
mkdir -p "$DB_FOLDER"
chmod 700 "$DB_FOLDER"

echo "✓ Data directory: $DB_FOLDER"

# Verify Xray binary exists
if [ -f /app/xray ]; then
  echo "✓ Xray Core found"
else
  echo "⚠ Warning: Xray Core binary not found at /app/xray"
fi

echo ""
echo "Panel initialization complete."
echo "Access the panel at: http://localhost:${XUI_PORT:-8080}"
echo "Default credentials: admin / admin"
echo ""
echo "IMPORTANT: Change your password immediately after first login."
echo ""

#!/usr/bin/env bash
set -e

# Pomp Net Panel environment setup
# Real Sanaei backend configuration

echo "Pomp Net Panel - Configuration Summary"
echo "======================================="
echo ""
echo "Environment Configuration:"
echo "  Panel Port:          ${XUI_PORT:-8080}"
echo "  Subscription Port:   ${XUI_SUBSCRIPTION_PORT:-2026}"
echo "  Database Location:   ${XUI_DB_FOLDER:-/app/data}"
echo "  Web Base Path:       ${XUI_INIT_WEB_BASE_PATH:-/}"
echo "  Log Level:           ${XUI_LOG_LEVEL:-info}"
echo "  Fail2ban Enabled:    ${XUI_ENABLE_FAIL2BAN:-true}"
echo ""

if [ -n "${PORT:-}" ] && [ "${PORT}" != "8080" ]; then
  echo "Render Deployment Detected:"
  echo "  Public Port:         ${PORT}"
  echo "  Panel will bind to:  0.0.0.0:${PORT}"
  echo ""
fi

echo "Database Type:       ${XUI_DB_TYPE:-sqlite}"
if [ "${XUI_DB_TYPE:-sqlite}" = "postgres" ]; then
  echo "  PostgreSQL DSN:      [configured]"
fi

echo ""
echo "Ready to start."
echo ""

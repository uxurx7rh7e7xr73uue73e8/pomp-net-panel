#!/usr/bin/env bash
set -e

# Health check for Pomp Net Panel
# Returns 0 if healthy, 1 if not

PANEL_PORT="${XUI_PORT:-8080}"
RENDER_PORT="${PORT:-}"

if [ -n "$RENDER_PORT" ] && [ "$RENDER_PORT" != "8080" ]; then
  PANEL_PORT="$RENDER_PORT"
fi

if ! command -v curl &> /dev/null; then
  # curl not available, try wget
  if command -v wget &> /dev/null; then
    wget -q -O- "http://127.0.0.1:${PANEL_PORT}/health" > /dev/null 2>&1 || exit 1
  else
    echo "Neither curl nor wget available for health check" >&2
    exit 1
  fi
else
  curl -fsS "http://127.0.0.1:${PANEL_PORT}/health" > /dev/null 2>&1 || exit 1
fi

exit 0

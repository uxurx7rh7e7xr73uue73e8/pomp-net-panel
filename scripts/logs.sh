#!/usr/bin/env bash
# View Pomp Net Panel Logs

echo ""
echo "📝 Pomp Net Panel Logs"
echo "(Press Ctrl+C to stop)"
echo ""

docker compose logs -f pompnet-panel

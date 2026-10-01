#!/usr/bin/env bash

echo "📊 Pomp Net Panel Status"
echo "═══════════════════════════════════════════════════════════════════"
echo ""

if ! command -v docker &> /dev/null; then
    echo "❌ Docker not found"
    exit 1
fi

echo "Container Status:"
docker compose ps

echo ""
echo "Logs (last 50 lines):"
echo "───────────────────────────────────────────────────────────────────"
docker compose logs --tail=50 pompnet-panel 2>/dev/null || echo "No logs available"

echo ""
echo "═══════════════════════════════════════════════════════════════════"
echo ""
echo "Access Panel:"
echo "  http://localhost:8080"
echo ""
echo "Check Health:"
echo "  curl http://localhost:8080/health"
echo ""

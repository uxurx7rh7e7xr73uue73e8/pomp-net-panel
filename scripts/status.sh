#!/usr/bin/env bash
# Pomp Net Panel Status Check

echo ""
echo "╔════════════════════════════════════════════════════════════════════════════════╗"
echo "║                    POMP NET PANEL - STATUS CHECK                               ║"
echo "╚════════════════════════════════════════════════════════════════════════════════╝"
echo ""

if ! command -v docker &> /dev/null; then
    echo "❌ Docker not installed"
    exit 1
fi

echo "📊 Container Status:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
docker compose ps

echo ""
echo "📝 Recent Logs (Last 30 lines):"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
if docker compose logs pompnet-panel 2>/dev/null; then
    docker compose logs --tail=30 pompnet-panel
else
    echo "No logs available"
fi

echo ""
echo "🔗 Access Points:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Panel:       http://localhost:8080"
echo "Health:      http://localhost:8080/health"
echo "Subscription: http://localhost:2026"
echo ""
echo "🌐 For Render:"
echo "Panel:       https://your-render-domain.onrender.com"
echo "Subscription: https://your-render-domain.onrender.com/sub/[subscription_id]"
echo ""

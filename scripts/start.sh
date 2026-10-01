#!/usr/bin/env bash
# Start Pomp Net Panel with Docker Compose

set -e

echo ""
echo "╔════════════════════════════════════════════════════════════════════════════════╗"
echo "║                 POMP NET PANEL - STARTING                                      ║"
echo "╚════════════════════════════════════════════════════════════════════════════════╝"
echo ""

echo "Building Docker image..."
echo "This may take 5-15 minutes on first run..."
echo ""

docker compose up -d

echo ""
echo "⏳ Waiting for panel to start..."
sleep 10

echo ""
echo "📊 Checking health..."
if bash scripts/healthcheck.sh; then
    echo ""
    echo "╔════════════════════════════════════════════════════════════════════════════════╗"
    echo "║                    ✅ PANEL STARTED SUCCESSFULLY                               ║"
    echo "╚════════════════════════════════════════════════════════════════════════════════╝"
    echo ""
    echo "🌐 Access Panel:"
    echo "   http://localhost:8080"
    echo ""
    echo "📝 Default Login:"
    echo "   Username: admin"
    echo "   Password: admin"
    echo ""
    echo "⚠️  IMPORTANT: Change password immediately!"
    echo ""
    echo "📖 View logs:"
    echo "   docker compose logs -f"
    echo ""
    echo "🛑 Stop panel:"
    echo "   docker compose down"
    echo ""
else
    echo ""
    echo "❌ Panel failed to start. Check logs:"
    echo "   docker compose logs pompnet-panel"
    exit 1
fi

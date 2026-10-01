#!/usr/bin/env bash
set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Pomp Net Panel - Docker Build & Run"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "Building Docker image..."
docker build -t pomp-net-panel:latest .

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Build complete!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "To run:"
echo "  docker compose up -d"
echo ""
echo "Or manually:"
echo "  docker run -d \\"
echo "    --name pomp-net \\"
echo "    -p 8080:8080 \\"
echo "    -p 2026:2026 \\"
echo "    -v pomp-data:/app/data \\"
echo "    pomp-net-panel:latest"
echo ""
echo "Access at: http://localhost:8080"
echo ""

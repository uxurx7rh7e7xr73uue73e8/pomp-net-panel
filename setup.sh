#!/usr/bin/env bash
set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Pomp Net Panel - Setup Script"
echo "  Based on official MHSanaei/3x-ui v3.8.5"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "[1/5] Creating directories..."
mkdir -p scripts data logs
chmod 755 scripts

echo "[2/5] Setting executable permissions..."
chmod +x scripts/*.sh 2>/dev/null || true

echo "[3/5] Verifying Docker..."
if ! command -v docker &> /dev/null; then
    echo "ERROR: Docker not found. Please install Docker first."
    exit 1
fi
echo "✓ Docker found: $(docker --version)"

echo "[4/5] Verifying Docker Compose..."
if ! command -v docker compose &> /dev/null; then
    echo "ERROR: Docker Compose not found. Please install it."
    exit 1
fi
echo "✓ Docker Compose found: $(docker compose version)"

echo "[5/5] Configuration ready."
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Ready to deploy!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Next steps:"
echo ""
echo "  For VPS deployment:"
echo "    docker compose up -d"
echo ""
echo "  Access panel at:"
echo "    http://localhost:8080"
echo ""
echo "  Default credentials:"
echo "    Username: admin"
echo "    Password: admin"
echo ""
echo "  For Render deployment:"
echo "    1. Push this repo to GitHub"
echo "    2. Create Web Service on Render"
echo "    3. Add Persistent Disk at /app/data"
echo ""

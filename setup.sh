#!/usr/bin/env bash
# Pomp Net Panel - Complete Render Deployment Setup
# This script sets up everything needed for Render deployment

set -e

echo ""
echo "╔════════════════════════════════════════════════════════════════════════════════╗"
echo "║                       POMP NET PANEL - SETUP                                    ║"
echo "║              Based on Official MHSanaei/3x-ui v3.8.5                           ║"
echo "║                     Production Ready - Real Xray                                ║"
echo "╚════════════════════════════════════════════════════════════════════════════════╝"
echo ""

echo "📋 Checking Prerequisites..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Check Docker
if ! command -v docker &> /dev/null; then
    echo "❌ Docker not found. Please install Docker first."
    echo "   Visit: https://docs.docker.com/get-docker/"
    exit 1
fi
echo "✅ Docker: $(docker --version)"

# Check Docker Compose
if ! command -v docker compose &> /dev/null; then
    echo "❌ Docker Compose not found. Please install it."
    exit 1
fi
echo "✅ Docker Compose: $(docker compose version | head -1)"

# Check Git
if ! command -v git &> /dev/null; then
    echo "⚠️  Git not found. You'll need it for Render deployment."
else
    echo "✅ Git: $(git --version)"
fi

echo ""
echo "📁 Creating Directory Structure..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

mkdir -p scripts logs data
chmod 755 scripts
echo "✅ Directories created"

echo ""
echo "🔧 Setting Up Configuration..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [ ! -f .env ]; then
    cp .env.example .env
    echo "✅ .env created from .env.example"
else
    echo "✅ .env already exists"
fi

echo ""
echo "🎯 Final Checks..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [ -f Dockerfile ]; then
    echo "✅ Dockerfile found"
else
    echo "❌ Dockerfile not found"
    exit 1
fi

if [ -f docker-compose.yml ]; then
    echo "✅ docker-compose.yml found"
else
    echo "❌ docker-compose.yml not found"
    exit 1
fi

echo ""
echo "╔════════════════════════════════════════════════════════════════════════════════╗"
echo "║                         ✅ SETUP COMPLETE                                       ║"
echo "╚════════════════════════════════════════════════════════════════════════════════╝"
echo ""
echo "🚀 Next Steps:"
echo ""
echo "   1️⃣  For Local Testing (VPS/Linux):"
echo "      docker compose up -d"
echo ""
echo "   2️⃣  For Render Deployment:"
echo "      • Push to GitHub"
echo "      • Create Web Service on Render"
echo "      • Add Persistent Disk at /app/data"
echo ""
echo "   3️⃣  Access Panel:"
echo "      • Local: http://localhost:8080"
echo "      • Render: https://your-render-domain.onrender.com"
echo ""
echo "   📝 Default Credentials:"
echo "      • Username: admin"
echo "      • Password: admin"
echo "      ⚠️  Change password immediately after first login!"
echo ""
echo "📖 Documentation:"
echo "   • Persian: DEPLOYMENT_GUIDE_FA.md"
echo "   • English: DEPLOYMENT_GUIDE_EN.md"
echo ""
echo "💬 Support:"
echo "   • Telegram: https://t.me/NovaTunneli"
echo "   • Issues: Check DEPLOYMENT_GUIDE_FA.md for troubleshooting"
echo ""

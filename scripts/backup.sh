#!/usr/bin/env bash
# Restore Pomp Net Panel from backup

set -e

echo ""
echo "╔════════════════════════════════════════════════════════════════════════════════╗"
echo "║                     POMP NET PANEL - DATABASE BACKUP                           ║"
echo "╚════════════════════════════════════════════════════════════════════════════════╝"
echo ""

DB_FOLDER="${XUI_DB_FOLDER:-./data}"
BACKUP_FILE="${1:-pompnet-backup-$(date +%Y%m%d-%H%M%S).tar.gz}"

if [ "$1" = "restore" ] && [ -n "$2" ]; then
    echo "📥 Restoring from: $2"
    if [ ! -f "$2" ]; then
        echo "❌ Backup file not found: $2"
        exit 1
    fi
    
    echo "Stopping panel..."
    docker compose down || true
    
    echo "Restoring database..."
    rm -rf "$DB_FOLDER"
    tar -xzf "$2" -C .
    
    echo "Starting panel..."
    docker compose up -d
    
    echo ""
    echo "✅ Restore complete"
    echo ""
else
    echo "💾 Creating backup..."
    
    if [ ! -d "$DB_FOLDER" ]; then
        echo "❌ Database folder not found: $DB_FOLDER"
        exit 1
    fi
    
    tar -czf "$BACKUP_FILE" "$DB_FOLDER"
    
    echo ""
    echo "✅ Backup created: $BACKUP_FILE"
    echo ""
    echo "📥 To restore:"
    echo "   bash scripts/backup.sh restore $BACKUP_FILE"
    echo ""
fi

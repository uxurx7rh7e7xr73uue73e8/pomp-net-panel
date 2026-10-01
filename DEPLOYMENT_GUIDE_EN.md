# Pomp Net Panel - Deployment & Usage Guide

## About Pomp Net Panel

**Pomp Net Panel** is a production-ready control panel for managing Xray-based proxy services, built on the official **MHSanaei/3x-ui v3.8.5** codebase.

### Official Upstream Base
- **Repository:** https://github.com/MHSanaei/3x-ui
- **Pinned Version:** v3.8.5
- **License:** GNU GPL v3.0

### Development Team
- **Developers:** Pomp Net Team
- **Contact:** @NovaTunneli (Telegram)

---

## Requirements

### VPS (Linux)
- Ubuntu 20.04+ or Debian 11+
- Docker & Docker Compose
- Minimum 1GB RAM
- 10GB disk space

### Render
- One Render Web Service
- One Render Persistent Disk (10GB recommended)
- Automatic HTTPS

---

## Installation & Setup

### 1. VPS Deployment

#### Step 1: Clone Repository

```bash
git clone https://github.com/uxurx7rh7e7xr73uue73e8/pomp-net-panel.git
cd pomp-net-panel
```

#### Step 2: Configure Environment

```bash
cp .env.example .env
```

Edit `.env` with your settings:

```bash
XUI_PORT=8080
XUI_SUBSCRIPTION_PORT=2026
XUI_DB_FOLDER=/app/data
```

#### Step 3: Start with Docker Compose

```bash
docker compose up -d
```

Check logs:

```bash
docker compose logs -f pompnet-panel
```

#### Step 4: Access Panel

```
http://YOUR_SERVER_IP:8080
```

---

### 2. Render Deployment

#### Step 1: Prepare Repository

1. Go to https://render.com and sign in
2. Create a **New Web Service**
3. Select GitHub repository: `uxurx7rh7e7xr73uue73e8/pomp-net-panel`

#### Step 2: Web Service Settings

```
Name:              pomp-net-panel
Environment:       Docker
Region:            Select your region
Branch:            main
Dockerfile path:   ./Dockerfile
Build command:     (leave empty)
Start command:     (leave empty)
Plan:              Starter or higher
Memory:            512 MB or more
Disk:              10 GB (with persistent disk)
```

#### Step 3: Environment Variables

Add these in **Environment** section:

```
XUI_DB_FOLDER=/app/data
XUI_PORT=8080
XUI_SUBSCRIPTION_PORT=2026
```

#### Step 4: Persistent Disk

1. Go to **Disks**
2. Click **Add Disk**
3. Configure:
   - **Mount Path:** `/app/data`
   - **Size:** 10 GB

#### Step 5: Deploy

Click **Deploy** and wait for build to complete.

#### Step 6: Access

When ready, Render provides a public URL:

```
https://pomp-net-panel-xxxx.onrender.com
```

---

## Initial Setup & Configuration

### Step 1: Login

1. Access panel URL
2. Username: `admin`
3. Password: `admin`

### Step 2: Change Password

**IMPORTANT:** Change password immediately after first login:

1. Click user icon (top-right)
2. Select **Change Password**
3. Enter new password
4. Click **Save**

### Step 3: Basic Configuration

1. Go to **Settings**
2. Configure **Web Base Path** (optional)
3. Enter **Server Information**:
   - Server name
   - Server IP or domain
   - Active ports

---

## Usage & Management

### Creating an Inbound

#### Step 1: Navigate to Inbounds

1. Select **Inbounds** from main menu
2. Click **New Inbound**

#### Step 2: Basic Configuration

```
Name:              my-vless-inbound
Protocol:          VLESS
Port:              443
Transport:         TCP / TLS
```

#### Step 3: Security Settings

```
TLS:               TLS
SNI:               example.com (your actual domain)
```

#### Step 4: Validate & Enable

1. Click **Add**
2. Panel generates and validates configuration
3. If valid, Xray reloads
4. Inbound shows as **Active**

### Creating a Client

#### Step 1: Select Inbound

1. Click an Inbound
2. Click **New Client**

#### Step 2: Client Configuration

```
Email/Name:        user@example.com
UUID:              [Auto-generated]
Traffic Limit:     100 GB (or unlimited)
Expiration Date:   (set or leave empty)
```

#### Step 3: QR Code & Configuration

1. After creation, QR Code is displayed
2. Click **Copy Config** to copy settings
3. Paste into client app (v2rayN, Clash, etc.)

### Using Subscription

Each client has a **real subscription URL**:

```
http://YOUR_SERVER:2026/sub/YOUR_SUBSCRIPTION_UUID
```

This URL contains:
- All real Inbound settings
- Client UUID
- Live updates (Traffic, Expiry)

Add this URL to your client app for automatic updates.

---

## VLESS REALITY

### About REALITY

REALITY is an anti-censorship protocol that disguises Xray traffic as normal HTTPS.

### Creating VLESS REALITY Inbound

#### Step 1: Inbound Setup

```
Name:              reality-vless
Protocol:          VLESS
Port:              443
Transport:         TCP
Security:          REALITY
```

#### Step 2: REALITY Configuration

Panel auto-generates:

```
Private Key:       [Auto-generated]
Public Key:        [Auto-generated]
Short ID:          [Auto-generated]
Server Name:       cdn.example.com (real domain)
Target:            1.1.1.1:443 (target server)
```

#### Step 3: Generate Clients

VLESS REALITY clients automatically receive correct REALITY settings.

---

## Monitoring & Optimization

### Dashboard

Dashboard displays real information:

```
CPU:               Actual processor usage
RAM:               Actual memory usage
Disk:              Disk space usage
Network:           Network traffic
Xray Status:       Running / Stopped / Error
Clients Online:    Number of active clients
Total Traffic:     Today's traffic total
```

### Xray Logs

View Xray logs in **Logs** section:

```
[Dashboard] → [Xray Log]
```

Logs include:
- Connection errors
- Xray startup/stop messages
- Configuration errors

---

## Troubleshooting

### Issue: Panel won't start

**Check:**

```bash
docker compose logs pompnet-panel
```

**Common solutions:**

1. Port 8080 in use:
   ```bash
   lsof -i :8080
   # Kill process or change port
   ```

2. Database access denied:
   ```bash
   sudo chmod 755 /app/data
   docker compose restart
   ```

### Issue: Xray not running

**Check:**

1. Go to **Logs** → **Xray Log**
2. Read error message

**Common causes:**

- **Port in use:** Another application uses the port
  ```bash
  netstat -tulnp | grep LISTEN
  ```

- **Invalid configuration:** Inbound settings are wrong
  - TLS without domain
  - Empty port
  - Invalid UUID

### Issue: Clients can't connect

**Check:**

1. Is Inbound **Active**?
2. Is port open in Firewall?
3. Does client have correct settings?

**Solutions:**

```bash
# Open firewall (Ubuntu)
sudo ufw allow 443/tcp
sudo ufw allow 80/tcp

# Check Xray
docker compose logs -f pompnet-panel
```

### Issue: Subscription not working

**Test URL:**

```bash
# VPS
curl http://SERVER_IP:2026/sub/YOUR_UUID

# Render
curl https://YOUR_DOMAIN/sub/YOUR_UUID
```

**Common causes:**

- Port 2026 not open in Firewall
- Render: Subscription via `/sub/` path

---

## Security Best Practices

### Password

✓ **Do:**
- Change password immediately
- Use strong password
- Store password securely

✗ **Don't:**
- Put password in README or Dockerfile
- Log passwords
- Share password

### Data

✓ **Do:**
- Backup database
- Restrict `/app/data` access
- Enable Render Persistent Disk

### 2FA

✓ **Enable:**

1. Go to **Settings**
2. Click **2FA**
3. Scan QR Code
4. Verify code

---

## Render vs VPS

### VPS

✓ All Xray inbound ports are public
✓ Subscription on port 2026
✓ Full control

### Render

✓ One public port (PORT)
✓ Automatic HTTPS
✓ Automatic persistence
✗ Xray inbound ports not public (reverse proxy needed)
✗ Subscription via `/sub/` endpoint

**For real VPN functionality with Xray inbounds, VPS is recommended.**

---

## Support & Contact

### Pomp Net Team

📱 **Telegram:** [@NovaTunneli](https://t.me/NovaTunneli)

### Upstream Project

📚 **MHSanaei/3x-ui:** https://github.com/MHSanaei/3x-ui
📖 **Documentation:** https://docs.sanaei.dev

---

## Version & Changelog

- **v1.0.0** (2026-10-01)
  - Initial release
  - Based on Sanaei 3x-ui v3.8.5
  - Full VPS & Render support
  - Pomp Net branding

---

**Last Updated:** October 2026

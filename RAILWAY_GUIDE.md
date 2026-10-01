# Pomp Net Panel - Railway Deployment Guide

## 📌 Important: Railway Platform Limitations

Railway is a **web service platform**, not a traditional VPS:
- ✅ One public HTTP/HTTPS port (automatic)
- ✅ Web panel access
- ✅ Subscription endpoint via `/sub/` path
- ✅ Persistent storage
- ❌ Multiple public ports (443, 80, 8443, etc)
- ❌ Xray inbound public exposure

**For real Xray inbound functionality with multiple public ports, use a VPS or dedicated server.**

---

## 🚀 Railway Deployment Steps

### 1️⃣ Fork/Push to GitHub

```bash
git clone https://github.com/uxurx7rh7e7xr73uue73e8/pomp-net-panel.git
cd pomp-net-panel
git remote set-url origin https://github.com/YOUR_USERNAME/pomp-net-panel.git
git push -u origin main
```

### 2️⃣ Create Railway Project

1. Go to https://railway.app (or https://railway.com)
2. Sign in / Create account
3. Click "New Project"
4. Select "Deploy from GitHub repo"
5. Connect your GitHub account
6. Select: `YOUR_USERNAME/pomp-net-panel`

### 3️⃣ Configure Railway Service

1. In Railway dashboard, click "New Service"
2. Select "GitHub repo"
3. Choose your `pomp-net-panel` repository

### 4️⃣ Environment Variables

Add these in Railway dashboard (Variables section):

```
XUI_DB_FOLDER=/app/data
XUI_DB_TYPE=sqlite
XUI_INIT_WEB_BASE_PATH=/
XUI_LOG_LEVEL=info
XUI_ENABLE_FAIL2BAN=false
TZ=Asia/Tehran
```

**NOTE:** Do NOT set PORT manually - Railway provides it automatically.

### 5️⃣ Volumes (Persistent Storage)

1. In Railway dashboard, go to "Volumes"
2. Click "+ New Volume"
3. Configure:
   - **Mount Path:** `/app/data`
   - **Size:** 5GB minimum (10GB recommended)

### 6️⃣ Dockerfile

Railway will automatically detect and use: **`Dockerfile.railway`**

### 7️⃣ Deploy

1. Click "Deploy"
2. Wait for build to complete (5-15 minutes)
3. Railway provides public URL:
   ```
   https://pomp-net-panel-xxxx.up.railway.app
   ```

---

## 🔓 First Access

When deployment is complete:

```
URL: https://your-railway-domain.up.railway.app
Username: admin
Password: admin
```

⚠️ **CHANGE PASSWORD IMMEDIATELY**

Go to: **Settings → Change Password**

---

## 📊 What Works on Railway

✅ **Web Panel**
- Dashboard
- Inbound management
- Client management
- Settings
- Authentication & 2FA

✅ **Subscriptions**
- Endpoint: `https://domain/sub/[UUID]`
- QR codes
- Real configs
- Traffic updates

✅ **Database**
- Persistent storage
- Survives restarts
- Survives redeployment

❌ **Xray Inbound Ports**
- Cannot expose 443, 80, 8443, etc publicly
- Only panel port (8080/443) is available
- For real inbound functionality, use VPS

---

## 🌐 Subscription on Railway

Since subscription port 2026 cannot be exposed, subscriptions work via HTTP route:

**Subscription URL (Railway):**
```
https://your-domain/sub/YOUR_SUBSCRIPTION_UUID
```

**To get subscription UUID:**
1. Login to panel
2. Go to Inbounds → Click inbound → Click client
3. Copy subscription link

---

## 📍 Health Check

Railway monitors: `GET /health`

Panel responds with HTTP 200 when healthy.

---

## 🐛 Troubleshooting

### Panel won't start

1. Check Railway logs:
   - Dashboard → Logs

2. Common issues:
   - Database folder permission
   - PORT binding
   - Build errors

### Database missing after restart

- Volume must be mounted at `/app/data`
- Check Railway Volumes configuration

### Subscription not working

1. Verify inbound is enabled
2. Test URL: `https://domain/sub/[UUID]`
3. Check panel logs for errors

### Xray won't start (expected on Railway)

**This is normal on Railway.** Railway only exposes web port.

For real Xray inbound functionality, deploy to VPS:
- Dedicated server
- Cloud VPS (Linode, DigitalOcean, Vultr)
- Self-hosted Linux server

---

## 💾 Backing Up Data

**Database is on Persistent Disk** at `/app/data`

Railway keeps data safe, but recommended:

1. Export clients/inbounds from panel
2. Keep local backups
3. Monitor disk usage

---

## 🚀 Upgrading

1. Update code on GitHub
2. Railway redeploys automatically
3. Data persists in volume

---

## 📞 Support

### Pomp Net Team
- Telegram: https://t.me/NovaTunneli

### Upstream (Sanaei/3x-ui)
- GitHub: https://github.com/MHSanaei/3x-ui
- Docs: https://docs.sanaei.dev

---

## ⚠️ Railway vs VPS Comparison

| Feature | Railway | VPS |
|---------|---------|-----|
| Web Panel | ✅ | ✅ |
| Subscriptions | ✅ | ✅ |
| Xray Inbound 443 | ❌ | ✅ |
| Xray Inbound 80 | ❌ | ✅ |
| Custom Ports | ❌ | ✅ |
| Persistent Data | ✅ | ✅ (manual) |
| Auto HTTPS | ✅ | ❌ (need SSL) |
| Cost | Low | Higher |

---

**For real Xray proxy functionality, use a VPS. Railway is best for panel/web UI only.**

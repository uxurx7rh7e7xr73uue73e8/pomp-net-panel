# Pomp Net Panel - Railway Edition

> **Pomp Net Exclusive Control Panel for Railway**
> 
> Based on Official MHSanaei/3x-ui v3.8.5
> 
> Developed by: Pomp Net Team | Telegram: [@NovaTunneli](https://t.me/NovaTunneli)

[![Railway Deploy](https://railway.app/button.svg)](https://railway.app?templateId=)

---

## 🎯 For Railway Only

This project is configured **exclusively for Railway**.

### ✅ What Works
- Full and real web panel
- Inbound and client management
- Real subscription system
- QR codes and subscription URLs
- Persistent database
- 2FA/TOTP authentication
- Automatic health checks

### ⚠️ Railway Limitations
- Xray inbound public ports cannot be exposed (platform limitation)
- For real Xray inbounds (443, 80, 8443), you need a VPS

---

## 🚀 Quick Start

### 1️⃣ Fork This Repository

```
https://github.com/uxurx7rh7e7xr73uue73e8/pomp-net-panel

Click: Fork
```

### 2️⃣ Deploy to Railway

**Option A: Simple (Recommended)**

1. Go to https://railway.app
2. Login / Sign up
3. "New Project"
4. "Deploy from GitHub repo"
5. Connect GitHub
6. Select `your-username/pomp-net-panel`
7. Deploy

**Option B: Command Line**

```bash
npm i -g @railway/cli
railway login
railway link
railway up
```

### 3️⃣ Railway Configuration

**Environment Variables:**
```
XUI_DB_FOLDER=/app/data
XUI_DB_TYPE=sqlite
XUI_INIT_WEB_BASE_PATH=/
XUI_LOG_LEVEL=info
TZ=Asia/Tehran
```

**Volumes:**
- Mount Path: `/app/data`
- Size: 10GB recommended

### 4️⃣ Access Your Panel

After deployment, Railway provides:
```
https://pomp-net-panel-xxxx.up.railway.app
```

**Login:**
```
Username: admin
Password: admin
```

⚠️ **Change password immediately!**

---

## 📚 Documentation

- **[راهنمای فارسی](RAILWAY_GUIDE_FA.md)** - فارسی complete guide
- **[English Guide](RAILWAY_GUIDE.md)** - Complete English documentation

---

## 💡 Usage

### Create Inbound

```
Inbounds → New Inbound
├─ Name: my-inbound
├─ Protocol: VLESS
├─ Port: 443 (example)
├─ Transport: TCP
└─ Security: TLS (with real domain)
```

### Create Client

```
[On Inbound] → New Client
├─ Email: user@example.com
├─ UUID: [Auto-generated]
├─ Traffic: 100GB
└─ Expiration: [Optional]
```

### Subscription

Each client has a subscription URL:
```
https://your-domain/sub/YOUR_UUID
```

Contains:
- Real configuration
- QR code
- Live traffic & expiry updates

---

## 🎨 Features

✅ Real Xray Core  
✅ Complete inbound/client management  
✅ Real subscription system  
✅ QR code generation  
✅ Traffic accounting  
✅ 2FA/TOTP  
✅ Live dashboard  
✅ Persistent database  
✅ Health checks  
✅ Auto HTTPS (Railway)  

---

## 🔐 Security

✅ Password hashing  
✅ Session management  
✅ Enable 2FA  
✅ HttpOnly cookies  
✅ CSRF protection  

---

## 🆘 Troubleshooting

### Panel won't start
- Check Railway logs
- Is volume mounted?
- Are variables correct?

### Database missing
- Volume must be at `/app/data`
- Check Railway Volumes

### Subscription not working
- Is inbound enabled?
- URL: `https://domain/sub/[UUID]`
- Check panel logs

### Xray Inbound Not Public
- **This is normal on Railway**
- Railway only has one public port
- For real inbounds: VPS required

---

## 📞 Support

- **Telegram:** [@NovaTunneli](https://t.me/NovaTunneli)
- **Upstream:** [MHSanaei/3x-ui](https://github.com/MHSanaei/3x-ui)
- **Documentation:** [docs.sanaei.dev](https://docs.sanaei.dev)

---

## 📋 Version

- **v1.0.0** - Railway Ready
- Based on: MHSanaei/3x-ui v3.8.5
- License: GPL-3.0

---

<div align="center">

### Railway Edition - Production Ready

**Pomp Net Panel** - Xray Control Panel for Railway

[Fork It](https://github.com/uxurx7rh7e7xr73uue73e8/pomp-net-panel/fork) → Deploy → Ready

</div>

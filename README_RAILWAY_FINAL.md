# Pomp Net Panel - Railway Edition

> **پنل اختصاصی پمپ نت برای Railway**
> 
> کنترل پنل Xray مبتنی بر رسمی MHSanaei/3x-ui v3.8.5
> 
> تولید توسط: تیم پمپ نت | تلگرام: [@NovaTunneli](https://t.me/NovaTunneli)

[![Railway Deploy](https://railway.app/button.svg)](https://railway.app?templateId=)

---

## 🎯 برای Railway

این پروژه **فقط برای Railway** تنظیم شده است.

### ✅ کاری می‌کند
- پنل وب کامل و واقعی
- مدیریت inbound و client
- سیستم اشتراک واقعی
- QR code و subscription URLs
- Database پایدار
- 2FA/TOTP
- Health check خودکار

### ⚠️ محدودیت‌های Railway
- Xray inbound ports عمومی نمی‌توانند exposed شوند (محدودیت پلتفرم)
- برای Xray inbound واقعی (443, 80, 8443) باید VPS استفاده کنید

---

## 🚀 شروع سریع

### 1️⃣ Fork کنید

```
https://github.com/uxurx7rh7e7xr73uue73e8/pomp-net-panel

کلیک کنید: Fork
```

### 2️⃣ Deploy روی Railway

**Option A: ساده (توصیه شده)**

1. برو به https://railway.app
2. Login/Sign up
3. "New Project"
4. "Deploy from GitHub repo"
5. اتصال GitHub
6. انتخاب `your-username/pomp-net-panel`
7. Deploy

**Option B: Command Line**

```bash
npm i -g @railway/cli
railway login
railway link
railway up
```

### 3️⃣ تنظیمات Railway

**Variables:**
```
XUI_DB_FOLDER=/app/data
XUI_DB_TYPE=sqlite
XUI_INIT_WEB_BASE_PATH=/
XUI_LOG_LEVEL=info
TZ=Asia/Tehran
```

**Volumes:**
- Mount Path: `/app/data`
- Size: 10GB

### 4️⃣ دسترسی

پس از deploy، Railway URL می‌دهد:
```
https://pomp-net-panel-xxxx.up.railway.app
```

**Login:**
```
Username: admin
Password: admin
```

⚠️ **فوری رمز را تغییر دهید!**

---

## 📚 راهنمای کامل

- **[راهنمای فارسی](RAILWAY_GUIDE_FA.md)** - توضیحات کامل فارسی
- **[English Guide](RAILWAY_GUIDE.md)** - Complete English documentation

---

## 💡 استفاده

### ایجاد Inbound

```
Inbounds → New Inbound
├─ Name: my-inbound
├─ Protocol: VLESS
├─ Port: 443 (مثال)
├─ Transport: TCP
└─ Security: TLS (با دامنه واقعی)
```

### ایجاد Client

```
[روی Inbound] → New Client
├─ Email: user@example.com
├─ UUID: [خودکار]
├─ Traffic: 100GB
└─ Expiration: [اختیاری]
```

### Subscription

هر client یک subscription URL دارد:
```
https://your-domain/sub/YOUR_UUID
```

این URL شامل:
- تمام تنظیمات واقعی
- QR code
- Traffic و expiry بلادرنگ

---

## 🎨 ویژگی‌ها

✅ Xray Core واقعی  
✅ مدیریت inbound/client کامل  
✅ سیستم اشتراک واقعی  
✅ QR code generation  
✅ Traffic accounting  
✅ 2FA/TOTP  
✅ Dashboard live  
✅ Persistent database  
✅ Health check  
✅ HTTPS خودکار (Railway)  

---

## 🔐 امنیت

✅ رمز عبور hashing  
✅ Session management  
✅ 2FA فعال کنید  
✅ HttpOnly cookies  
✅ CSRF protection  

---

## 🆘 مشکل‌ها

### پنل شروع نمی‌شود
- Railway logs بررسی کنید
- Volume مونت شده است؟
- Variables صحیح است؟

### Database گم شده
- Volume باید `/app/data` باشد
- Railway Volumes بررسی کنید

### Subscription کار نمی‌کند
- Inbound فعال است؟
- URL: `https://domain/sub/[UUID]`
- Panel logs بررسی کنید

### Xray Inbound عمومی نیست
- **طبیعی روی Railway است**
- Railway فقط یک port عمومی دارد
- برای inbound واقعی: VPS الزامی

---

## 📞 تماس

- **Telegram:** [@NovaTunneli](https://t.me/NovaTunneli)
- **Upstream:** [MHSanaei/3x-ui](https://github.com/MHSanaei/3x-ui)
- **Docs:** [docs.sanaei.dev](https://docs.sanaei.dev)

---

## 📋 نسخه

- **v1.0.0** - Railway Ready
- Based on: MHSanaei/3x-ui v3.8.5
- License: GPL-3.0

---

<div align="center">

### Railway Edition - Production Ready

**Pomp Net Panel** - کنترل پنل Xray برای Railway

[Fork کنید](https://github.com/uxurx7rh7e7xr73uue73e8/pomp-net-panel/fork) → Deploy → Ready

</div>

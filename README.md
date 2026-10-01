# Pomp Net Panel - Production Ready

> **پنل اختصاصی پمپ نت** - کنترل پنل Xray مبتنی بر رسمی MHSanaei/3x-ui v3.8.5

[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Docker](https://img.shields.io/badge/Docker-Ready-brightgreen)](https://www.docker.com/)
[![Render](https://img.shields.io/badge/Render-Compatible-blue)](https://render.com)

---

## 🚀 نمای کلی

**Pomp Net Panel** یک پنل کنترل تمام‌عیار برای مدیریت سرویس‌های Xray است که بر اساس کد رسمی **MHSanaei/3x-ui v3.8.5** ساخته شده است.

### ✨ ویژگی‌های اصلی

✅ **Xray Core واقعی** - مدیریت واقعی inbound و client  
✅ **دیتابیس پایدار** - SQLite یا PostgreSQL  
✅ **سیستم اشتراک واقعی** - QR code، subscription URL  
✅ **REALITY و TLS** - پروتکل‌های پیشرفته  
✅ **مدیریت کلاینت** - ترافیک، انقضا، فعال/غیرفعال  
✅ **داشبورد زنده** - CPU، RAM، ترافیک، وضعیت Xray  
✅ **2FA/TOTP** - احراز هویت دو‌عاملی  
✅ **VPS + Render** - بر روی هر دو کار می‌کند  
✅ **Health Check** - مراقبت سلامتی خودکار  
✅ **Fail2ban** - حفاظت برای IP limiting  

---

## 📋 الزامات

### برای VPS
- Ubuntu 20.04+ یا Debian 11+
- Docker & Docker Compose
- حداقل 1GB RAM
- 10GB فضای دیسک
- دسترسی root

### برای Render
- حساب Render
- Web Service Plan
- Persistent Disk (10GB)

---

## 🎯 شروع سریع

### 1️⃣ روی VPS

```bash
# کلون کردن
git clone https://github.com/uxurx7rh7e7xr73uue73e8/pomp-net-panel.git
cd pomp-net-panel

# اجرا
docker compose up -d

# دسترسی
http://YOUR_IP:8080
```

### 2️⃣ روی Render

1. به https://render.com بروید
2. **New Web Service** ایجاد کنید
3. مخزن GitHub انتخاب کنید: `uxurx7rh7e7xr73uue73e8/pomp-net-panel`
4. **Persistent Disk** اضافه کنید در `/app/data`
5. **Deploy** کنید

> **نکته:** متغیرهای محیطی به‌طور خودکار تنظیم می‌شوند

---

## 🔐 اولین ورود

```
نام‌کاربری: admin
رمز: admin
```

⚠️ **مهم:** رمز را بلافاصله تغییر دهید!

```
Settings → Change Password
```

---

## 📚 راهنماهای کامل

- **[راهنمای فارسی کامل](DEPLOYMENT_GUIDE_FA.md)** - تمام مراحل، Inbound، Client، REALITY، Troubleshooting
- **[English Guide](DEPLOYMENT_GUIDE_EN.md)** - Complete deployment and usage guide

---

## ⚙️ متغیرهای محیطی

```bash
XUI_PORT=8080                    # درگاه پنل
XUI_SUBSCRIPTION_PORT=2026       # درگاه اشتراک
XUI_DB_FOLDER=/app/data          # محل دیتابیس
XUI_DB_TYPE=sqlite               # نوع دیتابیس
XUI_INIT_WEB_BASE_PATH=/         # مسیر پایه وب
XUI_LOG_LEVEL=info               # سطح لاگ
XUI_ENABLE_FAIL2BAN=true         # فعال‌کردن Fail2ban
```

---

## 🛠️ مدیریت

### ایجاد Inbound

```
Inbounds → New Inbound
├─ نام: my-inbound
├─ پروتکل: VLESS
├─ درگاه: 443
├─ Transport: TCP
└─ Security: TLS (با دامنه واقعی)
```

### ایجاد Client

```
[روی Inbound] → New Client
├─ نام/Email: user@example.com
├─ UUID: [خودکار]
├─ ترافیک: 100GB
└─ تاریخ انقضا: (اختیاری)
```

### دریافت Subscription

```
http://YOUR_SERVER:2026/sub/YOUR_SUBSCRIPTION_UUID
```

---

## 📊 نظارت

### لاگ‌های Xray

```
Logs → Xray Log
```

### وضعیت سلامتی

```bash
curl http://localhost:8080/health
```

### مشاهده Status

```bash
bash scripts/status.sh
```

---

## 🐛 حل‌مسائل

### پنل شروع نمی‌شود

```bash
docker compose logs pompnet-panel

# درگاه 8080 استفاده‌شده است؟
lsof -i :8080
```

### Xray فعال نیست

1. بروید: **Logs → Xray Log**
2. خطا را بخوانید
3. تنظیمات Inbound را بررسی کنید

### کلاینت نمی‌تواند متصل شود

1. آیا Inbound **فعال** است؟
2. آیا درگاه در Firewall باز است؟
3. تنظیمات کلاینت صحیح است؟

```bash
# Firewall
sudo ufw allow 443/tcp
sudo ufw allow 80/tcp
```

---

## 🔒 امنیت

✅ **رمز عبور:**
- تغییر فوری رمز اولیه
- رمز قوی استفاده کنید
- در جای امن ذخیره کنید

✅ **داده:**
- دیتابیس پشتیبان تهیه کنید
- دسترسی `/app/data` محدود کنید
- Render Persistent Disk فعال کنید

✅ **2FA:**
```
Settings → 2FA → Enable
```

---

## 📈 VPS vs Render

| ویژگی | VPS | Render |
|------|-----|--------|
| درگاه‌های Xray عمومی | ✅ | ❌ |
| درگاه اشتراک 2026 | ✅ | ❌* |
| HTTPS خودکار | ❌ | ✅ |
| Persistence خودکار | ❌ | ✅ |
| کنترل کامل | ✅ | محدود |

*روی Render: اشتراک از طریق `/sub/` path

---

## 📞 تماس و پشتیبانی

### تیم Pomp Net
📱 **Telegram:** [@NovaTunneli](https://t.me/NovaTunneli)

### Upstream
📖 **MHSanaei/3x-ui:** https://github.com/MHSanaei/3x-ui  
📚 **مستندات:** https://docs.sanaei.dev

---

## 📝 لایسنس

GNU General Public License v3.0

این پروژه بر اساس کد رسمی MHSanaei/3x-ui (GPL-3.0) است.

---

## 🤝 توسعه‌دهندگان

**کدنویسی شده توسط:** تیم پمپ نت

**نسخه:** 1.0.0  
**تاریخ:** اکتبر 2026

---

<div align="center">

### 🎯 برای پروکسی واقعی و مطمئن

**Pomp Net Panel** - راه حل کامل مدیریت Xray

</div>

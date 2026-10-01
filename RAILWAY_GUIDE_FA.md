# راهنمای استقرار Pomp Net روی Railway

## 📌 محدودیت‌های پلتفرم Railway

Railway یک **پلتفرم خدمات وب** است، نه VPS سنتی:

✅ یک درگاه عمومی HTTP/HTTPS (خودکار)
✅ دسترسی به پنل وب
✅ Endpoint اشتراک از طریق مسیر `/sub/`
✅ ذخیره‌سازی دائمی

❌ چند درگاه عمومی (443، 80، 8443، و غیره)
❌ دسترسی عمومی به inbound های Xray

**برای عملکرد واقعی inbound های Xray با چند درگاه عمومی، از VPS یا سرور اختصاصی استفاده کنید.**

---

## 🚀 مراحل استقرار روی Railway

### 1️⃣ Push به GitHub

```bash
git clone https://github.com/uxurx7rh7e7xr73uue73e8/pomp-net-panel.git
cd pomp-net-panel
git remote set-url origin https://github.com/YOUR_USERNAME/pomp-net-panel.git
git push -u origin main
```

### 2️⃣ ایجاد پروژه در Railway

1. برو به https://railway.app
2. وارد شو / حساب بساز
3. کلیک کن روی "New Project"
4. انتخاب کن "Deploy from GitHub repo"
5. اتصال GitHub account
6. انتخاب: `YOUR_USERNAME/pomp-net-panel`

### 3️⃣ پیکربندی سرویس

1. در داشبورد Railway، کلیک کن "New Service"
2. انتخاب کن "GitHub repo"
3. انتخاب مخزن `pomp-net-panel` شما

### 4️⃣ متغیرهای محیط

در بخش Variables داشبورد Railway اضافه کن:

```
XUI_DB_FOLDER=/app/data
XUI_DB_TYPE=sqlite
XUI_INIT_WEB_BASE_PATH=/
XUI_LOG_LEVEL=info
XUI_ENABLE_FAIL2BAN=false
TZ=Asia/Tehran
```

**نکته:** PORT را به دست تنظیم نکن - Railway خودکار فراهم می‌کند.

### 5️⃣ ذخیره‌سازی دائمی (Volumes)

1. در داشبورد Railway، برو به "Volumes"
2. کلیک کن "+ New Volume"
3. پیکربندی کن:
   - **Mount Path:** `/app/data`
   - **Size:** 5GB حداقل (10GB توصیه‌شده)

### 6️⃣ Dockerfile

Railway خودکار استفاده می‌کند: **`Dockerfile.railway`**

### 7️⃣ Deploy

1. کلیک کن "Deploy"
2. صبر کن تا build تمام شود (5-15 دقیقه)
3. Railway URL عمومی فراهم می‌کند:
   ```
   https://pomp-net-panel-xxxx.up.railway.app
   ```

---

## 🔓 اولین ورود

بعد از اتمام deployment:

```
URL: https://your-railway-domain.up.railway.app
نام‌کاربری: admin
رمز: admin
```

⚠️ **فوراً رمز را تغییر دهید**

برو به: **Settings → Change Password**

---

## 📊 کارایی روی Railway

✅ **پنل وب**
- Dashboard
- مدیریت Inbound
- مدیریت Client
- تنظیمات
- احراز هویت & 2FA

✅ **اشتراکات**
- Endpoint: `https://domain/sub/[UUID]`
- کد QR
- تنظیمات واقعی
- به‌روزرسانی‌های ترافیک

✅ **دیتابیس**
- ذخیره‌سازی دائمی
- ماندگار پس از restart
- ماندگار پس از redeploy

❌ **Xray Inbound Ports**
- نمی‌تواند 443، 80، 8443 را به‌صورت عمومی expose کند
- فقط درگاه panel (8080/443) موجود است
- برای عملکرد inbound واقعی، از VPS استفاده کنید

---

## 🌐 اشتراک روی Railway

چون درگاه 2026 را نمی‌تواند expose کند، اشتراک‌ها از طریق HTTP route کار می‌کند:

**URL اشتراک (Railway):**
```
https://your-domain/sub/YOUR_SUBSCRIPTION_UUID
```

**برای دریافت UUID اشتراک:**
1. وارد پنل شو
2. برو به Inbounds → کلیک روی inbound → کلیک روی client
3. subscription link را کپی کن

---

## 📍 بررسی سلامتی

Railway نظارت می‌کند: `GET /health`

پنل پاسخ می‌دهد HTTP 200 وقتی سالم است.

---

## 🐛 حل‌مسائل

### پنل شروع نمی‌شود

1. لاگ‌های Railway را بررسی کن:
   - Dashboard → Logs

2. مسائل معمول:
   - اجازه دسترسی به پوشه دیتابیس
   - PORT binding
   - خطاهای build

### دیتابیس بعد از restart گم شده است

- Volume باید در `/app/data` mount شود
- پیکربندی Railway Volumes را بررسی کن

### اشتراک کار نمی‌کند

1. تأیید کن inbound فعال است
2. آزمایش URL: `https://domain/sub/[UUID]`
3. لاگ‌های پنل را بررسی کن

### Xray شروع نمی‌شود (طبیعی روی Railway)

**این طبیعی است روی Railway.** Railway فقط درگاه وب را expose می‌کند.

برای عملکرد واقعی inbound های Xray، به VPS deploy کنید:
- سرور اختصاصی
- Cloud VPS (Linode, DigitalOcean, Vultr)
- سرور Linux خود‌میزبانی

---

## 💾 پشتیبان‌گیری از داده‌ها

**دیتابیس روی Persistent Disk** در `/app/data` است

Railway داده‌ها را امن نگاه می‌دارد، اما توصیه شده است:

1. Export clients/inbounds از پنل
2. پشتیبان‌های محلی داشته باش
3. استفاده از فضا را نظارت کن

---

## 🚀 بروزرسانی

1. کد را روی GitHub بروزرسانی کن
2. Railway خودکار redeploy می‌کند
3. داده در volume باقی می‌ماند

---

## 📞 پشتیبانی

### تیم Pomp Net
- Telegram: https://t.me/NovaTunneli

### Upstream (Sanaei/3x-ui)
- GitHub: https://github.com/MHSanaei/3x-ui
- مستندات: https://docs.sanaei.dev

---

## ⚠️ مقایسه Railway با VPS

| ویژگی | Railway | VPS |
|------|---------|-----|
| پنل وب | ✅ | ✅ |
| اشتراکات | ✅ | ✅ |
| Xray Inbound 443 | ❌ | ✅ |
| Xray Inbound 80 | ❌ | ✅ |
| درگاه‌های سفارشی | ❌ | ✅ |
| داده دائمی | ✅ | ✅ (دستی) |
| HTTPS خودکار | ✅ | ❌ (نیاز SSL) |
| هزینه | کم | بیشتر |

---

**برای عملکرد واقعی proxy Xray، از VPS استفاده کنید. Railway بهتر است برای پنل/وب UI فقط.**

# راهنمای استقرار پنل اختصاصی پمپ نت

## درباره پروژه

**پنل اختصاصی پمپ نت** یک پنل کنترل پروداکشن‌رِدی برای مدیریت سرویس‌های پروکسی Xray است که بر اساس کد ر��می **MHSanaei/3x-ui v3.8.5** ساخته شده است.

### نسخه و مبنای رسمی
- **Upstream:** https://github.com/MHSanaei/3x-ui
- **نسخه پیشنهادی:** v3.8.5
- **License:** GNU GPL v3.0

### تیم توسعه
- **توسعه‌دهندگان:** تیم پمپ نت
- **تماس:** @NovaTunneli (Telegram)

---

## الزامات

### VPS (Linux)
- Ubuntu 20.04+ یا Debian 11+
- Docker و Docker Compose
- حداقل 1GB RAM
- 10GB فضای دیسک

### Render
- یک Render Web Service
- یک Render Persistent Disk (10GB توصیه‌شده)
- اتصال HTTPS خودکار

---

## نصب و راه‌اندازی

### 1. نصب برای VPS

#### مرحله 1: کلون کردن مخزن

```bash
git clone https://github.com/uxurx7rh7e7xr73uue73e8/pomp-net-panel.git
cd pomp-net-panel
```

#### مرحله 2: تنظیم متغیرهای محیط

```bash
cp .env.example .env
```

فایل `.env` را ویرایش کنید و تنظیمات خود را وارد کنید:

```bash
XUI_PORT=8080
XUI_SUBSCRIPTION_PORT=2026
XUI_DB_FOLDER=/app/data
```

#### مرحله 3: راه‌اندازی با Docker Compose

```bash
docker compose up -d
```

برای بررسی وضعیت:

```bash
docker compose logs -f pompnet-panel
```

#### مرحله 4: دسترسی به پنل

```
http://YOUR_SERVER_IP:8080
```

---

### 2. استقرار در Render

#### مرحله 1: نسخه تهیه کنید

1. به https://render.com بروید و وارد شوید
2. یک **New Web Service** ایجاد کنید
3. مخزن GitHub را انتخاب کنید: `uxurx7rh7e7xr73uue73e8/pomp-net-panel`

#### مرحله 2: تنظیمات Web Service

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

#### مرحله 3: متغیرهای محیط

در بخش **Environment** این متغیرها را اضافه کنید:

```
XUI_DB_FOLDER=/app/data
XUI_PORT=8080
XUI_SUBSCRIPTION_PORT=2026
```

#### مرحله 4: دیسک پایدار

1. به **Disks** بروید
2. **Add Disk** را کلیک کنید
3. تنظیمات:
   - **Mount Path:** `/app/data`
   - **Size:** 10 GB

#### مرحله 5: Deploy

بر **Deploy** کلیک کنید و صبر کنید تا ساخت تکمیل شود.

#### مرحله 6: دسترسی

هنگام آماده شدن، Render یک URL عمومی نمایش می‌دهد:

```
https://pomp-net-panel-xxxx.onrender.com
```

---

## ورود اول و تنظیمات اولیه

### مرحله 1: ورود

1. به URL پنل بروید
2. نام‌کاربری: `admin`
3. رمزعبور: `admin`

### مرحله 2: تغییر رمزعبور

**مهم:** بلافاصله بعد از ورود اول، رمزعبور را تغییر دهید:

1. بر آیکن کاربر کلیک کنید (گوشه بالا سمت راست)
2. **تغییر رمزعبور** را انتخاب کنید
3. رمز جدید را وارد کنید
4. **ذخیره** را کلیک کنید

### مرحله 3: تنظیمات اساسی

1. به **تنظیمات** بروید
2. **Web Base Path** را تنظیم کنید (اختیاری)
3. **اطلاعات سرور** را وارد کنید:
   - نام سرور
   - IP یا دامنه سرور
   - درگاه‌های فعال

---

## استفاده و مدیریت

### ایجاد Inbound (درگاه ورودی)

#### مرحله 1: رفتن به Inbounds

1. از منوی اصلی **Inbounds** را انتخاب کنید
2. بر **Inbound جدید** کلیک کنید

#### مرحله 2: تنظیمات اساسی

```
نام:              my-vless-inbound
پروتکل:          VLESS
درگاه:            443
Transport:        TCP / TLS
```

#### مرحله 3: تنظیمات امنیتی

```
RTLS:             TLS
SNI:              example.com (دامنه واقعی خود)
```

#### مرحله 4: تایید و فعال‌سازی

1. بر **اضافه کردن** کلیک کنید
2. پنل تنظیمات را تولید و تأیید می‌کند
3. اگر معتبر بود، Xray را دوباره بارگذاری می‌کند
4. Inbound به‌صورت **فعال** نمایش داده می‌شود

### ایجاد کلاینت

#### مرحله 1: انتخاب Inbound

1. روی یک Inbound کلیک کنید
2. بر **کلاینت جدید** کلیک کنید

#### مرحله 2: تنظیمات کلاینت

```
نام/ایمیل:       user@example.com
UUID:            [خودکار تولید]
ترافیک:          100 GB (یا نامحدود)
تاریخ انقضا:     (تنظیم کنید یا خالی بگذارید)
```

#### مرحله 3: QR Code و تنظیمات

1. پس از ایجاد، QR Code نمایش داده می‌شود
2. **نسخه تنظیمات** را کلیک کنید تا پیکربندی کپی شود
3. در برنامه کلاینت (v2rayN، Clash، و غیره) وارد کنید

### استفاده از Subscription

هر کلاینت یک **URL اشتراک واقعی** دارد:

```
http://YOUR_SERVER:2026/sub/YOUR_SUBSCRIPTION_UUID
```

این URL شامل:
- تمام تنظیمات واقعی Inbound
- UUID کلاینت
- تغییرات بلادرنگ (Traffic، Expiry)

در برنامه کلاینت می‌توان این URL را وارد کرد و پیکربندی‌ها خودکار وارد می‌شود.

---

## VLESS REALITY

### درباره REALITY

REALITY یک پروتکل ضد‌سانسور است که ترافیک Xray را به‌صورت ترافیک معمولی HTTPS نمایش می‌دهد.

### ایجاد VLESS REALITY Inbound

#### مرحله 1: تنظیم Inbound

```
نام:              reality-vless
پروتکل:          VLESS
Drillport:        443
Transport:        TCP
Security:         REALITY
```

#### مرحله 2: تنظیمات REALITY

پنل به‌طور خودکار تولید می‌کند:

```
Private Key:      [تولید خودکار]
Public Key:       [تولید خودکار]
Short ID:         [تولید خودکار]
Server Name:      cdn.example.com (دامنه واقعی)
Target:           1.1.1.1:443 (سرور هدف)
```

**نکته:** Dillport بزرگتر از Public Key باید داشته باشید.

#### مرحله 3: تولید کلاینت

کلاینت‌های VLESS REALITY به‌طور خودکار تنظیمات REALITY صحیح را دریافت می‌کنند.

---

## مانیتورینگ و بهینه‌سازی

### داشبورد

داشبورد اطلاعات واقعی نمایش می‌دهد:

```
CPU:              استفاده واقعی پروسسر
RAM:              استفاده واقعی حافظه
Disk:             استفاده فضای دیسک
Network:          ترافیک شبکه
Xray Status:      وضعیت Xray (Running/Stopped/Error)
Clients Online:   تعداد کلاینت‌های فعال
Total Traffic:    ترافیک کل امروز
```

### لاگ‌های Xray

با رفتن به **Logs** می‌توانید لاگ‌های Xray را ببینید:

```
[Dashboard] → [Xray Log]
```

لاگ‌ها شامل:
- خطاهای اتصال
- پیام‌های شروع/توقف Xray
- خطاهای تنظیم

---

## حل‌مسائل

### مشکل: پنل شروع نمی‌شود

**بررسی:**

```bash
docker compose logs pompnet-panel
```

**راه‌حل‌های معمول:**

1. درگاه 8080 توسط برنامه دیگر استفاده می‌شود:
   ```bash
   lsof -i :8080
   # Kill the process or change port
   ```

2. دسترسی به دیتابیس نشده:
   ```bash
   sudo chmod 755 /app/data
   docker compose restart
   ```

### مشکل: Xray فعال نیست

**بررسی:**

1. به **Logs** → **Xray Log** بروید
2. خطای نشان‌داده شده را بخوانید

**علل رایج:**

- **درگاه استفاده‌شده:** درگاه توسط برنامه دیگر استفاده می‌شود
  ```bash
  netstat -tulnp | grep LISTEN
  ```

- **تنظیم نامعتبر:** تنظیمات Inbound اشتباه است
  - TLS بدون دامنه
  - درگاه خالی
  - UUID نامعتبر

### مشکل: کلاینت‌ها نمی‌توانند متصل شوند

**بررسی:**

1. آیا Inbound **فعال** است؟
2. آیا درگاه در Firewall باز است؟
3. آیا کلاینت تنظیمات صحیح را دارد؟

**راه‌حل:**

```bash
# بررسی Firewall (Ubuntu)
sudo ufw allow 443/tcp
sudo ufw allow 80/tcp

# بررسی Xray
docker compose logs -f pompnet-panel
```

### مشکل: Subscription کار نمی‌کند

**بررسی URL:**

```bash
# VPS
curl http://SERVER_IP:2026/sub/YOUR_UUID

# Render
curl https://YOUR_DOMAIN/sub/YOUR_UUID
```

**علل رایج:**

- درگاه 2026 بدون Firewall
- Render: Subscription از طریق `/sub/` نیست

---

## نکات امنیتی

### رمزعبور

✓ **مطمئن شوید:**
- رمز را بلافاصله تغییر دهید
- رمز قوی استفاده کنید
- رمز را در جای امن ذخیره کنید

✗ **هرگز:**
- رمز را در README یا Dockerfile قرار ندهید
- رمز را در لاگ‌ها نوشت کنید
- رمز را به کسی بدهید

### Data

✓ **مطمئن شوید:**
- دیتابیس پشتیبان تهیه شود
- دسترسی به `/app/data` محدود است
- Render Persistent Disk فعال است

### 2FA

✓ **فعال کردن:**

1. به **Settings** بروید
2. **2FA** را کلیک کنید
3. QR Code را اسکن کنید
4. کد را تایید کنید

---

## Render vs VPS

### VPS

✓ تمام درگاه‌های Xray عمومی هستند
✓ Subscription روی درگاه 2026
✓ مدیریت کامل

### Render

✓ یک درگاه عمومی (PORT)
✓ HTTPS خودکار
✓ Persistence خودکار
✗ Xray inbound ports عمومی نیستند (نیاز به reverse proxy)
✗ Subscription از طریق `/sub/` endpoint

**برای پروکسی واقعی با Xray inbounds، VPS توصیه‌شده است.**

---

## اطلاعات تماس و پشتیبانی

### تیم Pomp Net

📱 **Telegram:** [@NovaTunneli](https://t.me/NovaTunneli)

### Upstream

📚 **MHSanaei/3x-ui:** https://github.com/MHSanaei/3x-ui
📖 **Documentation:** https://docs.sanaei.dev

---

## نسخه و تاریخچه

- **v1.0.0** (2026-10-01)
  - اولین نسخه
  - بر اساس Sanaei 3x-ui v3.8.5
  - پشتیبانی کامل VPS و Render
  - Pomp Net branding

---

**آخرین بروزرسانی:** اکتبر 2026

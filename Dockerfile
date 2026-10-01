# syntax=docker/dockerfile:1

# Pomp Net Panel - Production Ready
# Based on Official MHSanaei/3x-ui v3.8.5
# Real Xray Core Integration - Authentic Functionality

ARG XUI_VERSION=v3.8.5

# ============================================================
# Stage 1: Clone and Build Official Frontend
# ============================================================
FROM --platform=$BUILDPLATFORM node:22-alpine AS frontend-builder

WORKDIR /build

RUN apk add --no-cache git

# Clone official upstream v3.8.5 - THE REAL SOURCE
RUN git clone --depth 1 --branch v3.8.5 --single-branch \
    https://github.com/MHSanaei/3x-ui.git . && \
    git log -1 --oneline

# Build official frontend
WORKDIR /build/frontend
RUN npm ci --legacy-peer-deps 2>/dev/null || npm ci
RUN npm run build

# ============================================================
# Stage 2: Build Official Backend with Xray
# ============================================================
FROM golang:1.27-alpine AS backend-builder

WORKDIR /build
ARG TARGETARCH

RUN apk add --no-cache --update \
    build-base gcc curl unzip git bash ca-certificates

# Copy frontend build from previous stage
COPY --from=frontend-builder /build /build

# Build official Sanaei backend - THE REAL BACKEND
ENV CGO_ENABLED=1
ENV CGO_CFLAGS="-D_LARGEFILE64_SOURCE"

RUN go build -ldflags "-w -s" -o build/x-ui main.go || \
    (echo "Build failed"; exit 1)

# Download Xray Core binary - REAL XRAY
RUN bash DockerInit.sh "$TARGETARCH" || \
    (echo "Xray download failed"; exit 1)

# ============================================================
# Stage 3: Final Runtime Image
# ============================================================
FROM alpine:3.20

LABEL maintainer="Pomp Net" \
      description="Pomp Net Panel - Based on MHSanaei/3x-ui v3.8.5" \
      version="1.0.0" \
      org.opencontainers.image.source="https://github.com/uxurx7rh7e7xr73uue73e8/pomp-net-panel"

ENV TZ=Asia/Tehran
WORKDIR /app

RUN apk add --no-cache --update \
    ca-certificates \
    tzdata \
    fail2ban \
    bash \
    curl \
    openssl \
    dumb-init \
    && rm -rf /var/cache/apk/*

# Copy built artifacts from backend builder
COPY --from=backend-builder /build/build /app/
COPY --from=backend-builder /build/DockerEntrypoint.sh /app/
COPY --from=backend-builder /build/x-ui.sh /usr/bin/x-ui
COPY --from=backend-builder /build/internal/web/translation /app/internal/web/translation
COPY --from=backend-builder /build/internal/web/dist /app/internal/web/dist 2>/dev/null || true

# Configure fail2ban for IP limiting
RUN rm -f /etc/fail2ban/jail.d/alpine-ssh.conf && \
    cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local && \
    sed -i "s/^\[ssh\]$/&\nenabled = false/" /etc/fail2ban/jail.local && \
    sed -i "s/^\[sshd\]$/&\nenabled = false/" /etc/fail2ban/jail.local && \
    sed -i "s/#allowipv6 = auto/allowipv6 = auto/g" /etc/fail2ban/fail2ban.conf && \
    chmod +x /app/DockerEntrypoint.sh /app/x-ui /usr/bin/x-ui

# Official Sanaei environment configuration
ENV XUI_IN_DOCKER="true" \
    XUI_MAIN_FOLDER="/app" \
    XUI_ENABLE_FAIL2BAN="true" \
    XUI_DB_TYPE="sqlite" \
    XUI_DB_FOLDER="/app/data" \
    XUI_LOG_LEVEL="info" \
    XUI_DEBUG="false"

# Pomp Net Panel defaults
ENV XUI_PORT="8080" \
    XUI_SUBSCRIPTION_PORT="2026" \
    XUI_INIT_WEB_BASE_PATH="/"

# Expose ports
EXPOSE 8080 2026

# Persistent data volume
VOLUME ["/app/data"]

# Health check - Monitor real panel health
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD curl -fsS http://127.0.0.1:${XUI_PORT:-8080}/health || exit 1

# Entrypoint
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["./x-ui"]

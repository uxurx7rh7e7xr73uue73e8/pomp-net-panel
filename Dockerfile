# syntax=docker/dockerfile:1
# Pomp Net Panel
# Based on Official MHSanaei/3x-ui v3.8.5
# Real Sanaei backend, Xray integration, authentic functionality

ARG XUI_VERSION=v3.8.5

# ========================================================
# Stage 1: Download and build frontend
# ========================================================
FROM --platform=$BUILDPLATFORM node:22-alpine AS frontend

WORKDIR /src

RUN apk add --no-cache git curl

# Clone official upstream v3.8.5
RUN git clone --depth 1 --branch v3.8.5 --single-branch \
    https://github.com/MHSanaei/3x-ui.git .

WORKDIR /src/frontend
RUN npm ci --legacy-peer-deps 2>/dev/null || npm ci
RUN npm run build

# ========================================================
# Stage 2: Build official backend with Xray
# ========================================================
FROM golang:1.27-alpine AS builder

WORKDIR /src
ARG TARGETARCH

RUN apk --no-cache --update add \
    build-base \
    gcc \
    curl \
    unzip \
    git \
    bash

# Copy frontend build
COPY --from=frontend /src /src

# Build official Sanaei backend
ENV CGO_ENABLED=1
ENV CGO_CFLAGS="-D_LARGEFILE64_SOURCE"

RUN go build -ldflags "-w -s" -o build/x-ui main.go

# Download Xray core binary
RUN bash DockerInit.sh "$TARGETARCH"

# ========================================================
# Stage 3: Final Runtime Image
# ========================================================
FROM alpine:3.20

LABEL maintainer="Pomp Net" \
      description="Pomp Net Control Panel - Based on MHSanaei/3x-ui v3.8.5" \
      version="1.0.0"

ENV TZ=Asia/Tehran
WORKDIR /app

RUN apk add --no-cache --update \
    ca-certificates \
    tzdata \
    fail2ban \
    bash \
    curl \
    openssl \
    dumb-init

# Copy built artifacts
COPY --from=builder /src/build /app/
COPY --from=builder /src/DockerEntrypoint.sh /app/
COPY --from=builder /src/x-ui.sh /usr/bin/x-ui
COPY --from=builder /src/internal/web/translation /app/internal/web/translation
COPY --from=builder /src/internal/web/dist /app/internal/web/dist 2>/dev/null || true

# Setup fail2ban
RUN rm -f /etc/fail2ban/jail.d/alpine-ssh.conf && \
    cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local && \
    sed -i "s/^\[ssh\]$/&\nenabled = false/" /etc/fail2ban/jail.local && \
    sed -i "s/^\[sshd\]$/&\nenabled = false/" /etc/fail2ban/jail.local && \
    sed -i "s/#allowipv6 = auto/allowipv6 = auto/g" /etc/fail2ban/fail2ban.conf && \
    chmod +x /app/DockerEntrypoint.sh /app/x-ui /usr/bin/x-ui

# Official Sanaei environment variables
ENV XUI_IN_DOCKER="true" \
    XUI_MAIN_FOLDER="/app" \
    XUI_ENABLE_FAIL2BAN="true" \
    XUI_DB_TYPE="sqlite" \
    XUI_DB_FOLDER="/app/data" \
    XUI_LOG_LEVEL="info" \
    XUI_DEBUG="false"

# Pomp Net defaults
ENV XUI_PORT="8080" \
    XUI_SUBSCRIPTION_PORT="2026" \
    XUI_INIT_WEB_BASE_PATH="/"

EXPOSE 8080 2026
VOLUME ["/app/data"]

HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD curl -fsS http://127.0.0.1:${XUI_PORT:-8080}/health || exit 1

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["./x-ui"]

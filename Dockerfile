# Multi-stage build for Jitsi Meet with DevSeniorCode branding
# Stage 1: Build
FROM node:20-alpine AS builder

WORKDIR /app

# Install build dependencies
RUN apk add --no-cache \
    python3 \
    make \
    g++ \
    git

# Copy package files
COPY package*.json ./

# Install dependencies (using legacy-peer-deps for React Native compatibility)
RUN npm install --legacy-peer-deps

# Copy source code
COPY . .

# Build application
RUN npm run build

# Stage 2: Production
FROM nginx:alpine

# Install gettext (for envsubst)
RUN apk add --no-cache gettext

# Copy built files from builder
COPY --from=builder /app /usr/share/nginx/html

# Copy custom nginx config
COPY nginx-devsenior.conf /etc/nginx/templates/default.conf.template

# Set permissions
RUN chown -R nginx:nginx /usr/share/nginx/html

# Expose port
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget --quiet --tries=1 --spider http://localhost/ || exit 1

# Start nginx
CMD ["nginx", "-g", "daemon off;"]

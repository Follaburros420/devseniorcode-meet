# Production Dockerfile for DevSeniorCode Meet
# NO build stage - only static file deployment
# Build locally: make compile && make deploy

FROM nginx:alpine

# Install gettext (for envsubst)
RUN apk add --no-cache gettext

# Copy only necessary static files (no compilation)
COPY index.html /usr/share/nginx/html/
COPY title.html /usr/share/nginx/html/
COPY head.html /usr/share/nginx/html/
COPY base.html /usr/share/nginx/html/
COPY fonts.html /usr/share/nginx/html/
COPY body.html /usr/share/nginx/html/
COPY plugin.head.html /usr/share/nginx/html/
COPY manifest.json /usr/share/nginx/html/
COPY interface_config.js /usr/share/nginx/html/
COPY config.js /usr/share/nginx/html/

# Copy compiled assets (must be built locally first with: make compile && make deploy)
COPY libs/ /usr/share/nginx/html/libs/
COPY css/ /usr/share/nginx/html/css/
COPY images/ /usr/share/nginx/html/images/
COPY sounds/ /usr/share/nginx/html/sounds/
COPY static/ /usr/share/nginx/html/static/
COPY lang/ /usr/share/nginx/html/lang/

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

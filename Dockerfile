FROM docker:24-dind

# Install docker-compose
RUN apk add --no-cache \
    docker-compose \
    bash

# Set working directory
WORKDIR /app

# Copy compose files and configuration
COPY docker-compose.yml .
COPY .env .
COPY volumes/ ./volumes/
COPY dev/ ./dev/
COPY utils/ ./utils/

# Expose ports
EXPOSE 3000 8000 8443 5432 6543 4000

# Create startup script
COPY <<'EOF' /start.sh
#!/bin/bash
set -e

echo "Starting Docker daemon..."
dockerd-entrypoint.sh &

# Wait for Docker
until docker info >/dev/null 2>&1; do
  sleep 1
done

echo "Docker ready. Starting Supabase..."
cd /app
docker-compose pull
docker-compose up

EOF

RUN chmod +x /start.sh

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=120s --retries=3 \
  CMD docker ps | grep -q supabase-studio || exit 1

CMD ["/start.sh"]

# Stage 1: Build Quasar SPA
FROM node:20-alpine AS builder

WORKDIR /app

# Copy everything first
COPY frontend/ ./

# Install dependencies
RUN npm ci --legacy-peer-deps

# Build Quasar
RUN npm run build


# Stage 2: Production (Nginx serve static files)
FROM nginx:1.27-alpine

# Copy build artifacts
COPY --from=builder /app/dist/spa /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
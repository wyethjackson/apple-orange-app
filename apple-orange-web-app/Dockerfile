# === Common build stage ===
FROM node:20-alpine AS deps
WORKDIR /app
COPY package*.json ./
RUN npm install

# === Builder stage ===
FROM node:20-alpine AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npm run build

# === Production stage ===
FROM node:20-alpine AS production
WORKDIR /app
COPY --from=builder /app/.next ./.next
COPY --from=deps /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/next.config.mjs ./next.config.mjs
COPY --from=builder /app/public ./public
EXPOSE 3000
CMD ["npm", "run", "start"]


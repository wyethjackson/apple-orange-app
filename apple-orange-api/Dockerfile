FROM node:20-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 4000
RUN apk add --no-cache net-tools
CMD ["netstat", "-tuln", "&&", "node", "src/server.js"]


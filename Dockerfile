FROM node:12-alpine
WORKDIR /app
COPY . .
CMD ["node", "/app/src/index.js"]

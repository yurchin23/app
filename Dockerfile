FROM yurchin23/imageapp_jenkins
WORKDIR /app
COPY package* yarn.lock ./
COPY src ./src
CMD ["node", "/app/src/index.js"]

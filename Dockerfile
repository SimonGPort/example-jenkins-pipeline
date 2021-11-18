FROM node:10 AS ui-build
WORKDIR /usr/src/app
COPY my-app/ ./my-app/
WORKDIR /usr/src/app/my-app
RUN npm install --verbose
RUN npm run build

FROM node:10 AS server-build
WORKDIR /root/
COPY --from=ui-build /usr/src/app/my-app/build ./my-app/build
COPY api/package*.json ./api/
WORKDIR /root/api 
RUN npm install --verbose
COPY api/server.js ./api/

EXPOSE 3080

CMD ["node", "./api/server.js"]
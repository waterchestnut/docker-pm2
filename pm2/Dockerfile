FROM node:18
MAINTAINER porcupine "lingbinmeng@hotmail.com"

RUN npm install -g pm2@latest

VOLUME ["/app"]
COPY start /start
RUN chmod 755 /start
CMD ["/start"]

EXPOSE 8080
EXPOSE 3000
EXPOSE 80
EXPOSE 443
# 构建目录为根目录
FROM node:18
MAINTAINER menglb "lingbinmeng@hotmail.com"

RUN npm install -g pm2@latest

# install ffmpeg
ENV FFMPEG_VERSION 4.2.2
ADD ffmpeg-$FFMPEG_VERSION-amd64-static.tar.xz /opt/ffmpeg
ENV PATH $PATH:/opt/ffmpeg/ffmpeg-$FFMPEG_VERSION-amd64-static

VOLUME ["/app"]
COPY pm2/start /start
RUN chmod 755 /start
CMD ["/start"]

EXPOSE 8080
EXPOSE 3000
EXPOSE 80
EXPOSE 443
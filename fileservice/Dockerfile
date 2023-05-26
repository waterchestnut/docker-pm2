FROM node:18
MAINTAINER porcupine "lingbinmeng@hotmail.com"

# copy files
ADD soft/fonts.tar /tmp/data/font/
ADD soft/LibreOffice.tar.gz /tmp/data/libreoffice/
COPY soft/unoconv /tmp/data/

# modify /etc/apt/sources.list and update apt-get cache
# RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak \
# 	&& touch /etc/apt/sources.list \
# 	&& echo "deb http://mirrors.aliyun.com/debian/ jessie main non-free contrib" >> /etc/apt/sources.list \
# 	&& echo "deb http://mirrors.aliyun.com/debian/ jessie-proposed-updates main non-free contrib" >> /etc/apt/sources.list \
# 	&& echo "deb-src http://mirrors.aliyun.com/debian/ jessie main non-free contrib" >> /etc/apt/sources.list \
# 	&& echo "deb-src http://mirrors.aliyun.com/debian/ jessie-proposed-updates main non-free contrib" >> /etc/apt/sources.list \
# 	&& apt-get clean \
# 	&& rm -rf /var/lib/apt/lists/* \
# 	&& apt-get update --fix-missing -y -o Acquire-by-hash=yes -o Acquire::https::No-Cache=True -o Acquire::http::No-Cache=True

# update apt-get cache
RUN apt-get clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& apt-get update --fix-missing -y -o Acquire-by-hash=yes -o Acquire::https::No-Cache=True -o Acquire::http::No-Cache=True

# install lib & tools,imagemagick,unoconv
RUN apt-get install -y \
    libx11-dev libxext-dev zlib1g-dev libpng-dev \
    libjpeg-dev libfreetype6-dev libxml2-dev ghostscript imagemagick openjdk-8-jre

# install ttf-mscorefonts-installer
RUN apt-get install -y \
    cabextract xfonts-utils
RUN cd /opt/ \
    && wget http://httpredir.debian.org/debian/pool/contrib/m/msttcorefonts/ttf-mscorefonts-installer_3.6_all.deb \
    && dpkg -i ttf-mscorefonts-installer_3.6_all.deb

# install libreoffice
RUN cd /tmp/data/libreoffice \
	&& cd LibreOffice* \
	&& cd DEBS \
	&& dpkg -i *.deb \
	&& cd /tmp/data \
	&& mkdir /opt/libreoffice5.4/program/unoconv \
	&& cp unoconv /opt/libreoffice5.4/program/unoconv/

# install zh-cn fonts
RUN cd /tmp/data \
	&& mkdir -p /usr/local/fonts/zh-cn \
	&& cp font/fonts/* /usr/local/fonts/zh-cn/ \
	&& chmod 755 /usr/local/fonts/zh-cn \
	&& cd /usr/local/fonts/zh-cn \
	&& mkfontscale \
	&& mkfontdir \
	&& fc-cache -fv
	
# remove soft package
RUN apt-get clean && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/data

# install pm2
RUN npm install -g pm2@latest --registry=https://registry.npm.taobao.org

VOLUME ["/app"]

COPY start /start
RUN chmod 755 /start
CMD ["/start"]

EXPOSE 80
EXPOSE 443

FROM ubuntu:18.04

MAINTAINER chaun14, <contact@chaun14.fr>

RUN apt update \
    && apt upgrade -y \
    && apt autoremove -y \
    && apt autoclean \
    && apt -y install curl software-properties-common locales git cmake libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 libnss3 \
    && useradd -d /home/container -m container

    # Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8


WORKDIR /home/container

    # NodeJS
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - \
    && apt update \
    && apt -y upgrade \
    && apt -y install nodejs node-gyp \
    && apt -y install ffmpeg \
    && npm install discord.js node-opus opusscript \
    && npm install sqlite3 --build-from-source \
    && npm install better-sqlite3 --build-from-source

USER container
ENV  USER container
ENV  HOME /home/container



COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
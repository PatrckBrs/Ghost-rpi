# New version update 0.11.11
FROM patrckbrs/node.js:latest

LABEL maintainer "patrick@brunias.org"

ENV GHOST_VERSION=0.11.11

USER root
# Update sources && install packages
RUN DEBIAN_FRONTEND=noninteractive ;\
apt-get update && \
apt-get install --assume-yes unzip

WORKDIR /var/www/
RUN mkdir ghost && \
wget https://github.com/TryGhost/Ghost/releases/download/${GHOST_VERSION}/Ghost-${GHOST_VERSION}.zip && \
unzip Ghost-${GHOST_VERSION}.zip -d ghost

RUN apt-get -y remove wget unzip && \
    rm -rf /var/lib/apt/lists/*

RUN chown www-data:www-data ghost
RUN chown www-data:www-data -R ghost/*
RUN npm install pm2 -g

WORKDIR /var/www/ghost
RUN /bin/bash -c "time (npm install sqlite3)"
RUN npm install

EXPOSE 2368

ENV NODE_ENV production

RUN sed -e s/127.0.0.1/0.0.0.0/g ./config.example.js > ./config.js
RUN sed -i s/my-ghost-blog.com/www.codexatomos.org/g config.js

VOLUME ["/var/www/ghost/content/apps"]
VOLUME ["/var/www/ghost/content/data"]
VOLUME ["/var/www/ghost/content/images"]

CMD ["pm2", "start", "index.js", "--name", "Ghost", "--no-daemon"]

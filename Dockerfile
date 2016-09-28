FROM patrckbrs/node.js:latest

USER root
# Update sources && install packages
RUN DEBIAN_FRONTEND=noninteractive ;\
apt-get update && \
apt-get install --assume-yes wget unzip

WORKDIR /var/www/
RUN mkdir ghost && \
wget https://ghost.org/zip/ghost-0.11.0.zip && \
unzip ghost-*.zip -d ghost

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
CMD ["pm2", "start", "index.js", "--name", "Ghost", "--no-daemon"]

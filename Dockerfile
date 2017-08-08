# New version update 0.11.9
FROM patrckbrs/node.js:latest

LABEL maintainer "Patrick Brunias <patrick@brunias.org>"

ENV GHOST_VERSION=1.5.0
ENV NPM_CONFIG_LOGLEVEL warn

USER root
# Update sources && install packages
RUN DEBIAN_FRONTEND=noninteractive ;\
apt-get update 

WORKDIR /var/www/
RUN npm install -g ghost-cli

RUN useradd ghost
RUN addgroup ghost www-data
RUN chown ghost:www-data .

RUN ghost install local --no-start

USER ghost

WORKDIR /var/www/ghost

RUN ghost install local --no-start

EXPOSE 2368
EXPOSE 2369

VOLUME ["/var/www/ghost/content/apps"]
VOLUME ["/var/www/ghost/content/data"]
VOLUME ["/var/www/ghost/content/images"]

ENV NODE_ENV production
RUN sed -ie s/127.0.0.1/0.0.0.0/g config.production.json

CMD ["ghost", "run", "--production", "--ip", "0.0.0.0"]

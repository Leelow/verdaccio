FROM node:slim

COPY . /verdaccio

RUN adduser --disabled-password --gecos "" verdaccio && \
  mkdir -p /verdaccio/storage /verdaccio/conf && \
  chown -R verdaccio.verdaccio /verdaccio

USER verdaccio
WORKDIR /verdaccio

RUN npm install --production

ADD ./conf/docker-mongodb.yaml /verdaccio/conf/config.yaml

EXPOSE 4873

VOLUME ["/verdaccio/conf", "/verdaccio/storage"]

CMD ["/verdaccio/bin/verdaccio", "--config", "/verdaccio/conf/config.yaml", "--listen", "0.0.0.0:4873"]

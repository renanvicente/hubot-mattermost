FROM mhart/alpine-node:4
MAINTAINER Heitor Lessa <heitor.lessa@hotmail.com>
WORKDIR /src

# If you have native dependencies, you'll need extra tools
RUN apk add --update make gcc g++ \
&& npm install -g npm \
&& npm install -g yo generator-hubot \
&& adduser hubot -h /home/hubot -D -s /bin/sh

ENV HOME /home/hubot
USER hubot
WORKDIR /home/hubot

RUN echo "No" | yo hubot --adapter mattermost --name matterbot --defaults \
&& sed -i '/heroku/d' external-scripts.json

CMD ["-a", "mattermost"]
ENTRYPOINT ["./bin/hubot"]

EXPOSE 8080

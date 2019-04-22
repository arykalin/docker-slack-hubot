FROM node:11-alpine

RUN \
  apk add --no-cache jq && \
  npm install -g --production --silent coffee-script generator-hubot yo && \
  mkdir /hubot && chown node:node /hubot

WORKDIR /hubot

USER node
RUN \
  yo --no-insight hubot --name="Hubot" --defaults && \
  sed -i '/npm install/d' bin/hubot && \
  npm install --save --production --silent \
    hubot-slack
RUN npm install --save --production --silent \
        hubot-jenkins-enhanced
ADD hubot/hubot-scripts.json /hubot/
ADD hubot/external-scripts.json /hubot/

ENTRYPOINT ["./bin/hubot"]

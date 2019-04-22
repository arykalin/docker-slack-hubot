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
#patching issue https://github.com/codeandfury/hubot-jenkins-enhanced/issues/23
ADD hubot/node_modules/hubot-jenkins-enhanced/src/jenkins-enhanced.coffee /hubot/node_modules/hubot-jenkins-enhanced/src/

ADD hubot/hubot-scripts.json /hubot/
ADD hubot/external-scripts.json /hubot/
ADD  hubot/scripts /hubot/scripts

ENTRYPOINT ["./bin/hubot"]

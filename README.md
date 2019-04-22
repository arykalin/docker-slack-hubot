# slack-hubot
To build a docker image

```
docker build -t dockhubot .
```  
To run the docker image  

```
docker run --name redis -d redis redis-server --appendonly yes
docker run -e HUBOT_SLACK_TOKEN=$HUBOT_SLACK_TOKEN \
-e HUBOT_JENKINS_URL=$HUBOT_JENKINS_URL=https://jenkins.eng.venafi.com \
-e HUBOT_JENKINS_AUTH=$HUBOT_JENKINS_AUTH \
-e REDIS_URL=redis://redis
-d dockhubot
```

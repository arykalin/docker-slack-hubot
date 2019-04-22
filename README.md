# slack-hubot
To build a docker image

```
docker build -t dockhubot .
```

Get creds variables
```
source credentials
```  
To run the docker image  

```
docker run --name redis -d redis redis-server --appendonly yes
docker run -e HUBOT_SLACK_TOKEN=$HUBOT_SLACK_TOKEN \
-e HUBOT_JENKINS_URL=$HUBOT_JENKINS_URL \
-e HUBOT_JENKINS_AUTH=$HUBOT_JENKINS_AUTH \
-e REDIS_URL=redis://redis
-d dockhubot
```

Or use docker-compose:  
```
cat << EOF > docker-compose.yml
version: '2'
services:
  redis:
    image: redis
    volumes:
      - redis:/data
  hubot:
    image: dockhubot
    ports: 
      - 1080:8080
    command: -a slack
    depends_on:
      - redis
    environment:
      HUBOT_SLACK_TOKEN: $HUBOT_SLACK_TOKEN
      REDIS_URL: redis://redis
      HUBOT_JENKINS_AUTH: $HUBOT_JENKINS_AUTH
      HUBOT_JENKINS_URL: $HUBOT_JENKINS_URL

volumes:
  redis:
  
networks:
  default:
    driver: bridge
    ipam:
      driver: default
      config:
      - subnet: 172.38.29.0/24
EOF

docker-compose up -d
```

## Running Mattermost, Redis and Hubot using Docker for testing environments

In this example, we will be running a Docker container using Hubot-Mattermost image and therefore we need the following:

* Docker Network that will be used by Mattermost, Redis and Hubot
* Mattermost container
* Redis container

This is mainly for **testing purposes**, for production environment you better build your own image from Hubot-Mattermost in which you may want to include your custom Hubot scripts.

### Creating a Docker network

A network will be used to bridge these containers so they can reach out to each other. In case you already have Consul or any service discovery, feel free to use your existent one.

```sh
docker network create hubot.net
```

#### Running Mattermost container

Here we bind mattermost default local port 80 to 8065 at the Docker Host.

```sh
docker run --net hubot.net --name mattermost-dev -d --publish 8065:80 mattermost/platform
```

#### Running Redis container

For redis, we simply run the following and we should be good to go:

```sh
docker run --net hubot.net --name redis-server -d redis
```

##### Putting them all together

Before we run a Hubot container, you will need to do the following:

* Access http://<dockerhost>:8065/ to set up Mattermost 
* [Enable Incoming and Outgoing Hooks](https://github.com/mattermost/platform/blob/master/doc/integrations/webhooks/Incoming-Webhooks.md#enabling-incoming-webhooks), then take note of the values
    * Use the following Callback URLs value for Outgoing: ```http://matterbot.hubot.net:8080/hubot/incoming```
    * **If this is your first time using Hubot-mattermost adapter, please familiarize yourself with [environment variables required](https://github.com/renanvicente/hubot-mattermost/blob/master/README.md#environment-variables)**

With those values taken, you can now launch Hubot by replacing the placeholders '<<< >>>' with the values you got out of Mattermost Webhooks:

```sh
docker run -it -e MATTERMOST_ENDPOINT='/hubot/incoming' \
    -e MATTERMOST_INCOME_URL='http://mattermost-dev.hubot.net/hooks/<<<oxgpse6iy7b9jn9ua978c7koae>>>' \
    -e MATTERMOST_TOKEN='<<<b1xmc5zb5pf4j83fzcrrk3uwtw>>>' \
    -e MATTERMOST_ICON_URL='https://s3-eu-west-1.amazonaws.com/renanvicente/toy13.png' \
    -e MATTERMOST_HUBOT_USERNAME='matterbot' \
    -e REDIS_URL="redis://redis-server.hubot.net:6379/hubot" \
    --net hubot.net --name "matterbot" -d lessa/hubot-mattermost
```

If Mattermost Webhooks and Hubot environment variables are set correct, you should be able to successfully call Hubot in the channel you specified for the Outgoing Hook:

```sh
matterbot ping
matterbot help
```

If you want to have Hubot working in any public channel, please follow instructions given [here](https://github.com/renanvicente/hubot-mattermost#example-with-hubot-sending-to-any-public-channel)


## Extra information

Hubot installation is under ```/home/hubot``` in case you want to play around with ```external-scripts.json``` and ```scripts``` folder. Be aware that using Docker volumes will not be sufficient only as you will also need to implement ```npm install``` to ensure they are installed in your custom image.
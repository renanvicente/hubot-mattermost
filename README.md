![Mattermost logo](https://avatars0.githubusercontent.com/u/9828093?v=3&s=200)

[![Downloads](https://img.shields.io/npm/dm/hubot-mattermost.svg)](https://www.npmjs.com/package/hubot-mattermost)
[![Version](https://img.shields.io/npm/v/hubot-mattermost.svg)](https://github.com/anroots/hubot-mattermost/releases)
[![Licence](https://img.shields.io/npm/l/express.svg)](https://github.com/anroots/hubot-mattermost/blob/master/LICENSE)

# hubot-mattermost

[Hubot](https://github.com/github/hubot) adapter for [Mattermost](http://www.mattermost.org/).
Enables to add a Hubot bot to Mattermost.

## Getting your bot connected to Mattermost

Here is a sample run:

![picture of a sample interaction with mattermost](https://cloud.githubusercontent.com/assets/5564668/11096122/672edb84-8890-11e5-9a69-4662a42b3012.png)

## Installation

* Follow the "[Getting Started With Hubot](https://hubot.github.com/docs/)" guide to get a local installation of Hubot
* When you run the command `yo hubot` it should ask for an adapter, input "mattermost" so it can download this adapter automatically for you
* Create an incoming webhook and outgoing webhook integration in your mattermost. You can follow the instructions on [Incoming Webhooks](https://github.com/mattermost/platform/blob/master/doc/integrations/webhooks/Incoming-Webhooks.md#enabling-incoming-webhooks) and [Outgoing Webhooks](https://github.com/mattermost/platform/blob/master/doc/integrations/webhooks/Outgoing-Webhooks.md#enabling-outgoing-webhooks) to setup.
* Set the environment variables MATTERMOST_ENDPOINT, MATTERMOST_INCOME_URL and MATTERMOST_TOKEN based on your mattermost configuration.
* ***It's important to remember that if you don't run Hubot alongside with Mattermost (locally) you must ensure that Mattermost instance can connect to the machine where Hubot is installed as it will be running on port 8080***. This is due to Webhooks nature (both Incoming and Outgoing) where a HTTP POST will be send both ways for communication purposes (sending and receiving Mattermost/Hubot messages).

## Example Installation

  ```sh
npm install -g yo generator-hubot
yo hubot --adapter mattermost
  ```

## Environment variables

The adapter requires the following environment variables to be defined prior to run a Hubot instance:

* `MATTERMOST_ENDPOINT` _string, default: none_ - URI that you want hubot to listen, need to be the uri you specified when creating your outgoing webhook on mattermost. Example: if you create your outgoing webhook with http://127.0.0.1:8080/hubot/incoming you should set it with /hubot/incoming.
* `MATTERMOST_INCOME_URL` _string, default: none_ - Your incoming webhook url. Example: http://<your mattermost instance>:<port>/hooks/ncwc66caqf8d7c4gnqby1196qo
* `MATTERMOST_TOKEN` _string, default: none_ - Token from your outgoing webhook.

In addition, the following optional variables can be set:

* `MATTERMOST_CHANNEL` _string, default: none_ - Override the channel that you want to reply to.
* `MATTERMOST_ICON_URL` _string, default: none_ - If Enable Overriding of Icon from Webhooks is enabled you can set a url with the icon that you want for your hubot.
* `MATTERMOST_HUBOT_USERNAME` _string, default: Hubot's name_ - You can set a custom username to respond in mattermost. If Enable Overriding of Usernames from Webhooks, this name is shown in mattermost.
* `MATTERMOST_SELFSIGNED_CERT` _boolean, default: none_ - If true it will ignore if MATTERMOST_ENDPOINT has a self signed certificate.

## Example for Environment variables
  ```sh
export MATTERMOST_ENDPOINT=/hubot/incoming # listen endpoint
export MATTERMOST_CHANNEL=town-square # optional: if you want to override your channel
export MATTERMOST_INCOME_URL=http://<your mattermost instance>:<port>/hooks/ncwc66caqf8d7c4gnqby1196qo # your mattermost income url
export MATTERMOST_TOKEN=oqwx9d4khjra8cw3zbis1w6fqy # your mattermost token
export MATTERMOST_ICON_URL=https://s3-eu-west-1.amazonaws.com/renanvicente/toy13.png # optional: if you want to override hubot icon
export MATTERMOST_HUBOT_USERNAME="matterbot" # optional: if you want to override hubot name
export MATTERMOST_SELFSIGNED_CERT=true # optional: if you want to ignore self signed certificate

  ```

## Example with Hubot sending to multiple specific channels only

Although Mattermost doesn't allow multiple channels on a single Incoming/Outgoing hook you can do the following in order to allow Hubot to listen to multiple channels:

* Create an Outgoing Hook for each channel to wish to have Hubot. That will give you multiple tokens
* Set MATTERMOST_TOKEN global variable with multiple tokens separated by comma

Example:
```sh
export MATTERMOST_ENDPOINT=/hubot/incoming # listen endpoint
export MATTERMOST_INCOME_URL=http://localhost:8065/hooks/3eo1wjwyxibnmd5rsusk4h4pgh # your mattermost income url
export MATTERMOST_TOKEN="epboqd78ufyi58nxktgzq9zpho,7ftco7zg5fdkixw7j3okmuo3eo" # your mattermost token for **each Channel**
export MATTERMOST_ICON_URL=https://s3-eu-west-1.amazonaws.com/renanvicente/toy13.png # optional: if you want to override hubot icon
export MATTERMOST_HUBOT_USERNAME="matterbot" # optional: if you want to override hubot name
```

Note that there is ***no*** need to create multiple Incoming Hooks as we can use a single Incoming Hook but specify what channel we want to send the message to as [described in the documentation](http://docs.mattermost.org/integrations/webhooks/Incoming-Webhooks.html).


Run hubot with mattermost adapter.
  ```sh
bin/hubot -a mattermost
  ```

## Example with Hubot sending to ANY public channel

As pointed out by [Andre](https://github.com/devTechi) there's a [new Giphy implementation](https://github.com/mattermost/mattermost-integration-giphy) that leverages an Outgoing hook with **no channel set**, in which Mattermost allows us to send messages to any channel based on **Trigger Words** feature only.

Therefore, if all you want to do is to have Hubot to send/reply to all public channels, all you will need to do is:

* Create an Outgoing Hook, leave Channel untouched (blank), set the <Hubot Name> (e.g. *matterbot*) as Trigger Word and specify the callback URL as you would normally
* Set *MATTERMOST_TOKEN* global variable with the token given by the newly Outgoing hook created

Example of a hook created using this pattern:
```sh
URLs: http://localhost:8080/hubot/incoming
Trigger Words: matterbot
Token: 15r8ybrxhpgifc3rycdjrf6m8e
```

Example of global variables set that will send to **any public channel** if message starts with **matterbot**:
```sh
export MATTERMOST_ENDPOINT=/hubot/incoming # listen endpoint
export MATTERMOST_INCOME_URL=http://localhost:8065/hooks/3eo1wjwyxibnmd5rsusk4h4pgh # your mattermost income url
export MATTERMOST_TOKEN="epboqd78ufyi58nxktgzq9zpho,7ftco7zg5fdkixw7j3okmuo3eo" # your mattermost token
export MATTERMOST_ICON_URL=https://s3-eu-west-1.amazonaws.com/renanvicente/toy13.png # optional: if you want to override hubot icon
export MATTERMOST_HUBOT_USERNAME="matterbot" # optional: if you want to override hubot name
```

### Known issues

With this approach [**Hubot.hear method**](https://hubot.github.com/docs/scripting/#hearing-and-responding) will be invalidated, since a POST message will only be sent from Mattermost if Hubot name (_MATTERMOST_HUBOT_USERNAME="matterbot"_) is mentioned.

So, if you have the following in any of your custom scripts -- that will **no longer work**:

```coffeescript
robot.hear /HEY$/i, (msg) ->
	msg.reply "Yo!"
```

#### Workaround

In order to have both working (send messages to any public channel + hubot actively listening to certain messages) you would need to:

* A) Have an Outgoing Hook with **no channel set** with each 'Hear' (e.g 'hey') regex separated by comma
* B) Have an Outgoing Hook to each Channel you want 'Hear' method to work
* Once you define which option you prefer you must update MATTERMOST_TOKEN with the additional token you got (_MATTERMOST_TOKEN="<token1>,<token2>"), otherwise Hubot will simply ignore the incoming event

Example of Outgoing Hook created using option A:
```sh
URLs: http://localhost:8080/hubot/incoming
Trigger Words: hey
Token: 9r8i6s86hbgc8r57hqc5ywijac
```

By simply typing: *"hey"* in any channel Hubot should be able to respond with *"Yo!"* as Mattermost now sends a POST to Hubot.

## License
The MIT License. See `LICENSE` file.

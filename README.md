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

* Follow the "[Getting Started With Hubot](https://github.com/github/hubot/blob/master/docs/README.md)" guide to get a local installation of Hubot
* When `yo hubot` command asks for an adapter, enter "mattermost"
* Create a incoming webhook and outgoing webhook integration in your mattermost. You can follow the instruction on [Incoming Webhooks](https://github.com/mattermost/platform/blob/master/doc/integrations/webhooks/Incoming-Webhooks.md) and [Outgoing Webhooks](https://github.com/mattermost/platform/blob/master/doc/integrations/webhooks/Outgoing-Webhooks.md) to setup.
* Set the environment variables MATTERMOST_ENDPOINT, MATTERMOST_INCOME_URL and MATTERMOST_TOKEN based on your mattermost configuration.

## Example Installation

  ```sh
npm install -g yo generator-hubot
yo hubot --adapter mattermost
  ```

## Environment variables

The adapter requires the following environment variables to be defined:

* `MATTERMOST_ENDPOINT` _string, default: none_ - URI that you want the hubot to listen, need to be the uri you specified when creating your outgoing webhook on mattermost. Example: if you create your outgoing webhook with http://127.0.0.1:8080/hubot/incoming you should set it with /hubot/incoming.
* `MATTERMOST_INCOME_URL` _string, default: none_ - Your incoming webhook url. Example: http://<your mattermost instance>:<port>/hooks/ncwc66caqf8d7c4gnqby1196qo
* `MATTERMOST_TOKEN` _string, default: none_ - Token from your outgoing webhook.

In addition, the following optional variables can be set:

* `MATTERMOST_CHANNEL` _string, default: none_ - Override the channel that you want to reply to.
* `MATTERMOST_ICON_URL` _string, default: none_ - if Enable Overriding of Icon from Webhooks is enabled you can set a url with the icon that you want for your hubot.
* `MATTERMOST_HUBOT_USERNAME` _string, default: none_ - if Enable Overriding of Usernames from Webhooks you can set a custom username to show in mattermost.

## Exemple for Environment variables
  ```sh
export MATTERMOST_ENDPOINT=/hubot/incoming # listen endpoint
export MATTERMOST_CHANNEL=town-square # optional: if you want to override your channel
export MATTERMOST_INCOME_URL=http://<your rocketchat instance>:<port>/hooks/ncwc66caqf8d7c4gnqby1196qo # your mattermost income url
export MATTERMOST_TOKEN=oqwx9d4khjra8cw3zbis1w6fqy # your mattermost token
export MATTERMOST_ICON_URL=https://s3-eu-west-1.amazonaws.com/renanvicente/toy13.png # optional: if you want to override hubot icon
export MATTERMOST_HUBOT_USERNAME="moerae bot" # optional: if you want to override hubot name

  ```

Run hubot with mattermost adapter.
  ```sh
bin/hubot -a mattermost
  ```

## License
The MIT License. See `LICENSE` file.

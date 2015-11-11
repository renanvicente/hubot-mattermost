# hubot-mattermost
A hubot adapter for Mattermost

## Installation

1. Install `hubot-mattermost`.
  ```sh
npm install -g yo generator-hubot
yo hubot --adapter mattermost
  ```

2. Set environment variables.
  ```sh
export MATTERMOST_ENDPOINT=/hubot/incoming # listen endpoint
export MATTERMOST_CHANNEL=Town Square # optional: if you want to override your channel
export MATTERMOST_INCOME_URL=http://<your rocketchat instance>:<port>/hooks/ncwc66caqf8d7c4gnqby1196qo # your mattermost income url
export MATTERMOST_TOKEN=oqwx9d4khjra8cw3zbis1w6fqy # your mattermost token
export MATTERMOST_ICON_URL=https://s3-eu-west-1.amazonaws.com/renanvicente/toy13.png # optional: if you want to override hubot icon
export MATTERMOST_HUBOT_USERNAME="moerae bot" # optional: if you want to override hubot name

  ```

3. Run hubot with mattermost adapter.
  ```sh
bin/hubot -a mattermost
  ```

## License
The MIT License. See `LICENSE` file.

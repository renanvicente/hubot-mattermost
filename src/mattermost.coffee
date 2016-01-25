try
  {Robot,Adapter,TextMessage,User} = require 'hubot'
catch
  prequire = require('parent-require')
  {Robot,Adapter,TextMessage,User} = prequire 'hubot'

class Mattermost extends Adapter

  send: (envelope, strings...) ->
    for str in strings
      data = JSON.stringify({
        icon_url: @icon,
        channel: @channel ? envelope.user?.room ? envelope.room, # send back to source channel only if not overwritten,
        username: @username,
        text: str
      })
      @robot.http(@url)
        .header('Content-Type', 'application/json')
        .post(data) (err, res, body) ->
          if err
            console.log err

  reply: (envelope, strings...) ->
    for str in strings
      @send envelope, "@#{envelope.user.name}: #{str}"

  command: (command, strings...) ->
    @send command, strings

  run: ->
    # Tell Hubot we're connected so it can load scripts
    @emit "connected"
    @tokens = process.env.MATTERMOST_TOKEN
    @channel = process.env.MATTERMOST_CHANNEL
    @endpoint = process.env.MATTERMOST_ENDPOINT
    @url = process.env.MATTERMOST_INCOME_URL
    @icon = process.env.MATTERMOST_ICON_URL
    @username = process.env.MATTERMOST_HUBOT_USERNAME
    @selfsigned = this.getBool(process.env.MATTERMOST_SELFSIGNED_CERT) if process.env.MATTERMOST_SELFSIGNED_CERT
    if @selfsigned then process.env.NODE_TLS_REJECT_UNAUTHORIZED = "0"
    unless @tokens?
      @robot.logger.emergency "MATTERMOST_TOKEN is required"
      process.exit 1
    unless @endpoint?
      @robot.logger.emergency "MATTERMOST_ENDPOINT is required"
      process.exit 1
    unless @url?
      @robot.logger.emergency "MATTERMOST_INCOME_URL is required"
      process.exit 1
    @robot.router.post @endpoint, (req, res) =>
     # split string values by ',' as process.env return type string no matter what has been defined (eg array, string, int)
     for token in @tokens.split(',')
       if token is req.body.token
         msg = req.body.text
         user = @robot.brain.userForId(req.body.user_id)
         user.name = req.body.user_name
         user.room = req.body.channel_name
         @robot.receive new TextMessage(user, msg)
         res.writeHead 200, 'Content-Type': 'text/plain'
         res.end()

  getBool: (val) ->
    return !!JSON.parse(String(val).toLowerCase());

exports.use = (robot) ->
  new Mattermost robot

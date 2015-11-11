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
        channel: @channel,
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
      @send envelope.user, "@#{envelope.user.name}: #{str}"

  command: (command, strings...) ->
    @send command, strings

  run: ->
    # Tell Hubot we're connected so it can load scripts
    @emit "connected"
    @token = process.env.MATTERMOST_TOKEN
    @channel = process.env.MATTERMOST_CHANNEL
    @endpoint = process.env.MATTERMOST_ENDPOINT
    @url = process.env.MATTERMOST_INCOME_URL 
    @icon = process.env.MATTERMOST_ICON_URL 
    @username = process.env.MATTERMOST_HUBOT_USERNAME
    unless @token?
      @robot.logger.emergency "MATTERMOST_TOKEN is required"
      process.exit 1
    unless @endpoint?
      @robot.logger.emergency "MATTERMOST_ENDPOINT is required"
      process.exit 1
    unless @url?
      @robot.logger.emergency "MATTERMOST_INCOME_URL is required"
      process.exit 1
    @robot.router.post @endpoint, (req, res) =>
     if @token is req.body.token
       msg = req.body.text
       user = @robot.brain.userForId(req.body.user_id)
       user.name = req.body.user_name
       user.room = req.body.channel_name
       @robot.receive new TextMessage(user, msg)
       res.writeHead 200, 'Content-Type': 'text/plain'
       res.end()

exports.use = (robot) ->
  new Mattermost robot

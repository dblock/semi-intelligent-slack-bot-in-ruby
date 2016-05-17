require 'http'
require 'json'
require 'faye/websocket'
require 'eventmachine'
require 'sinatra'
require 'slack-ruby-bot'

Thread.new do
  EM.run do
  end
end

class Hi < SlackRubyBot::Commands::Base
  command 'hi' do |client, data, _match|
    client.message text: "hi <@#{data.user}>", channel: data.channel
  end
end

get '/' do
  if params.key?('code')
    rc = JSON.parse(HTTP.post('https://slack.com/api/oauth.access', params: {
      client_id: ENV['SLACK_CLIENT_ID'],
      client_secret: ENV['SLACK_CLIENT_SECRET'],
      code: params['code']
    }))

    token = rc['bot']['bot_access_token']

    SlackRubyBot::Server.new(token: token).start_async

    "Team Successfully Registered"
  else
    "Hello World"
  end
end

require 'slack-ruby-bot'

class Bot < SlackRubyBot::Bot
  command 'hi' do |client, data, _match|
    client.message text: "hi <@#{data.user}>", channel: data.channel
  end
end

Bot.instance.run

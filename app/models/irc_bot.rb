class IrcBot
  require 'cinch'

  def initialize server, channel, nick
    bot = Cinch::Bot.new do
      configure do |c|
        c.server = "irc.z.je"
        c.channels = ["#battlehack"]
      end

      on :message, "hello" do |m|
        m.reply "Hello, #{m.user.nick}"
      end
    end

    bot.start
  end

end
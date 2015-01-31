class IrcBot
  require 'cinch'

  def self.boot
    bot = Cinch::Bot.new do
      $message_ids = []
      configure do |c|
        c.nick = "federation-relay"
        c.server = "localhost"
        c.port = 2000
        c.channels = ["#battlehack"]
      end

      on :message, "hello" do |m|
        
        Timer(5) { 
          messages = Message.fetch_from_url "http://joel.coopcoopcoop.net", "user", "lol"
          messages = messages.reject{|mess| $message_ids.include?(mess.uuid)}
          messages.each do |message|
            $message_ids << message.uuid
            Channel("#battlehack").send("<#{message.sender_host}>: #{message.text}") 
          end
          
        }
      end

      on :message, "quit" do |m|
        quit
      end


    end

    bot.start
  end

end
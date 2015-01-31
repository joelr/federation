class AudioTx
  require 'fldigi'
  attr_accessor :fldigi

  def initialize
    @fldigi = Fldigi.new()
  end

  def self.boot
    new.boot
  end

  def boot
    $message_ids = []
    messages = Message.fetch_from_url "http://joel.coopcoopcoop.net", "user", "lol"
    messages.each do |message|
      $message_ids << message.uuid
    end
    while true do
      messages = Message.fetch_from_url "http://joel.coopcoopcoop.net", "user", "lol"
      messages = messages.reject{|mess| $message_ids.include?(mess.uuid)}
      messages.each do |message|
        message = Message.new message.as_json
        $message_ids << message.uuid
        puts fldigi.get_tx_data()
        fldigi.add_tx_string(MessageSerializer.new(message).to_json)
        fldigi.send_buffer()
        sleep 2
      end
    end
  end
end

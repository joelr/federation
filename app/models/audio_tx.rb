class AudioTx
  require 'fldigi'
  attr_accessor :fldigi, :message_processing

  def initialize
    @fldigi = Fldigi.new()
      @message_processing = '{"message":{"text":"test!!!","sender_host":"joel.coopcoopcoop.net","filter":null,"created_at":0,"uuid":"e3bf4347-dacf-49c9-a3e2-fd923e9a7ecc","encrypted":false}}{"message":{"text":"test!!!","sender_host":"joel.coopcoopcoop.net","filter":null,"created_at":0,"uuid":"e3bf4347-dacf-49c9-a3e2-fd923e9a7ecc","encrypted":false}}'
  end

  def self.boot
    new.boot
  end

  def process_message
    puts @message_processing
    puts complete_message?.inspect
    if complete_message?
      puts complete_message.inspect
      p = complete_message.message.as_json.symbolize_keys.slice(:text, :sender_host, :host, :type, :filter, :uuid)
      p[:uuid] = p[:uuid] + Time.now.to_s
      Message.build_from_payload p
      @message_processing = ''
    end
  end

  def complete_message
    m = @message_processing.split('{"message":').last.split('}}').first
    Hashie::Mash.new JSON.parse('{"message":' + m + '}}')
  end

  def complete_message?
    return false unless @message_processing.include?('{"message"')
    return false unless @message_processing.include?('}}')
    return false unless @message_processing.split('{"message"').last.include?('}}')
    return true
  end

  def boot
    $message_ids = []
    messages = Message.fetch_from_url "http://joel.coopcoopcoop.net", "user", "lol"
    messages.each do |message|
      $message_ids << message.uuid
      puts message.text
    end
    while true do
      messages = Message.fetch_from_url "http://joel.coopcoopcoop.net", "user", "lol"
      sleep 2
      #messages = Message.all.order("id desc").limit(2)
      messages = messages.reject{|mess| $message_ids.include?(mess.uuid)}
      messages.each do |message|
        message = Message.new message.as_json.symbolize_keys.slice(:text, :sender_host, :host, :type, :filter, :uuid)
        $message_ids << message.uuid
        puts message.text
        fldigi.add_tx_string(MessageSerializer.new(message).to_json)
        
        fldigi.send_buffer()
      end
      @message_processing << fldigi.get_rx_data()
      process_message
    end
  end
end

class Message < ActiveRecord::Base
  include Apiable

  def self.fetch_from_url url, user, pass
    m = Message.new
    r = m.api_get url, "messages", {}, {username: user, password: pass}
    r["messages"]
  end

  def self.publish from, params
    params[:host] ||= '*'
    params[:password] = "OMG"
    pass = params.delete :password
    if pass.presence
      params[:text] = Enc.cipher(pass, params[:text])
    end
    m = create params.merge({sender_host: from.host, uuid: SecureRandom.uuid})
    m.broadcast
  end

  def broadcast
    FederationBroadcaster.publish({
      type: 'messages/receive',
      data: self.as_json.merge(type: type),
      host: host
    })
  end

  def self.build_from_payload payload
    message = Message.where(uuid: payload[:uuid]).first_or_initialize
    message.text = payload[:text]
    message.sender_host = payload[:sender_host]
    message.host = payload[:host]
    message.filter = payload[:filter]

    if true || payload[:sender_host].include?("local")
      api_status = Hashie::Mash.new(status: 'ok')
    else
      api_status = api_get payload[:sender_host], 'messages/validate/' + payload[:uuid], {checksum: message.checksum}
    end
    unless message.persisted?
      if payload[:sender_host].include?("local") || api_status.status == "ok"
        message.update_attributes payload
      else
        return false
      end
    end
    message
  end

  def checksum
    Digest::MD5.hexdigest "#{text}#{sender_host}#{host}#{uuid}#{filter}"
  end

  def self.find_and_validate uuid, checksum
    m = Message.where(uuid: uuid).first
    return false unless m
    m.checksum == checksum
  end
end

class Message < ActiveRecord::Base
  include Apiable

  def self.publish from, params
    params[:host] ||= '*'
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

    if payload[:sender_host].include?("local")
      api_status = Hashie::Mash.new
    else
      api_status = api_get payload[:sender_host], 'messages/validate/' + payload[:uuid], {checksum: m.checksum}
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

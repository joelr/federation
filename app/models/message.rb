class Message < ActiveRecord::Base
  def self.publish from, params
    params[:host] ||= '*'
    m = create params.merge({sender_host: from, uuid: SecureRandom.uuid})
    m.broadcast
  end

  def broadcast
    FederationBroadcaster.publish({
      type: 'messages/receive',
      data: self.as_json.merge(type: type)
    })
  end

  def self.build_from_payload payload
    message = Message.where(uuid: payload[:uuid]).first_or_initialize
    unless message.persisted?
      message.update_attributes params
    end
    message
  end
end

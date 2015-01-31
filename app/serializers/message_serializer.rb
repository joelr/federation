class MessageSerializer < ActiveModel::Serializer
  require 'digest'
  attributes :text, :sender_host, :filter, :created_at, :uuid, :sender_name

  def created_at
    object.created_at.to_i * 1000
  end

  def sender_name
    host = Host.find_host(object.sender_host)
    host.name
  end

  def include_sender_name?
    !sender_name.blank?
  end
end

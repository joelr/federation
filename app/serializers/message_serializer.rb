class MessageSerializer < ActiveModel::Serializer
  require 'digest'
  attributes :text, :sender_host, :filter, :created_at, :uuid, :sender_name, :encrypted, :radio

  def created_at
    object.created_at.to_i * 1000
  end

  def sender_name
    host = Host.find_host(object.sender_host)
    host.try :name
  end

  def include_sender_name?
    !sender_name.blank?
  end

  def encrypted
    (text.strip || "")[-1] == "=" || (text.strip || "").include?("/")
  end

  def radio
    uuid.include?(" ")
  end
end

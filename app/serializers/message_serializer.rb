class MessageSerializer < ActiveModel::Serializer
  require 'digest'
  attributes :text, :sender_host, :filter, :created_at, :uuid

  def uuid
    Digest::MD5.hexdigest object.host
  end

  def created_at
    object.created_at.to_i * 1000
  end
end

class PrivateHostSerializer < ActiveModel::Serializer
  require 'digest'
  attributes :host, :name, :uuid, :charity_id, :url

  def uuid
    Digest::MD5.hexdigest object.host
  end
end

class HostSerializer < ActiveModel::Serializer
  require 'digest'
  attributes :host, :name, :uuid, :paypal_email, :charity_id

  def uuid
    Digest::MD5.hexdigest object.host
  end
end

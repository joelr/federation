class PrivateHostSerializer < ActiveModel::Serializer
  require 'digest'
  attributes :host, :name, :uuid, :charity_id, :url, :paypal_email, :has_email

  def paypal_email
    object.has_email?
  end

  def uuid
    Digest::MD5.hexdigest object.host
  end
end

class HostSerializer < ActiveModel::Serializer
  require 'digest'
  attributes :host, :name, :uuid, :paypal_email, :charity, :charity_url, :last_broadcasted_at

  def uuid
    Digest::MD5.hexdigest object.host
  end

  def charity_url
    "http://www.justgiving.com/4w350m3/donation/direct/charity/#{object.charity}?amount=5&currency=AUD&exitUrl=#{object.localhost.url}"
  end

  def include_paypal_email?
    !!paypal_email.presence
  end

  def include_name?
    !!name.presence
  end

  def last_broadcasted_at
    object.messages.first.created_at.to_i * 1000
  end

  def include_last_broadcasted_at
    object.messages.any?
  end
end

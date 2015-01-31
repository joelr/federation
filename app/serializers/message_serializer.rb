class MessageSerializer < ActiveModel::Serializer
  require 'digest'
  attributes :text, :sender_host, :filter, :created_at, :uuid, :sender_name, :encrypted, :radio, :paypal_email, :charity_url

  def created_at
    object.created_at.to_i * 1000
  end

  def sender_name
    host.try :name
  end

  def include_sender_name?
    !sender_name.blank?
  end

  def paypal_email
    !!host.try(:has_email?)
  end

  def charity_url
    if host
      h = host
      h.localhost = object.localhost
      HostSerializer.new(h).charity_url
    end
  end

  def include_charity_url?
    !charity_url.nil?
  end

  def encrypted
    (text.strip || "")[-1] == "=" || (text.strip || "").include?("/")
  end

  def radio
    uuid.include?(" ")
  end

  def host
    @host ||= Host.find_host(object.sender_host)
  end
end

class TipRequester
  attr_accessor :localhost

  def self.initialize host
    @localhost = host
  end

  def request_email_from_host host
    FederationBroadcaster.publish_to_host(host, {
      type: 'inbound_email_request',
      host: localhost,
    }
  end

  def request_email_from_host host
    FederationBroadcaster.publish_to_host(host, {
      type: 'inbound_email_response',
      host: localhost,
      email: localhost.paypal_email,
    }
  end
end
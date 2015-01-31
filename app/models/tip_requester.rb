class TipRequester
  attr_accessor :localhost

  def initialize host
    @localhost = host
  end

  def request_email_from_host host
    FederationBroadcaster.publish_to_host({
      type: 'inbound_email_request',
      data: {
        host: localhost.host,
      }
    }, host)
  end

  def send_email_to_host host
    FederationBroadcaster.publish_to_host({
      type: 'inbound_email_response',
      data: {
        host: localhost.host,
        email: localhost.paypal_email,
      }
    }, host)
  end
end
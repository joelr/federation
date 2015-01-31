class HostBroadcaster

  def self.broadcast host, method = 'host_register'
    FederationBroadcaster.publish({
      type: method,
      data: {
        host: host.host,
        name: host.name,
        url: host.url,
        paypal_email: host.paypal_email,
        charity_id: host.charity_id,
      }
    })
  end

  def self.broadcast_local
    Host.local_hosts.each do |host|
      data = broadcast host, 'host_register'
      data.each do |payload|
        payload = payload.as_json.symbolize_keys.slice :host, :url, :paypal_email, :charity_id, :name
        Host.build_from_payload payload
      end
    end
    broadcast_all
  end

  #broadcast all sends a discover, which doesn't republish.
  def self.broadcast_all
    Host.all.each do |host|
      broadcast host, 'discover'
    end
  end
end

class HostBroadcaster

  def self.broadcast host
    FederationBroadcaster.publish({
      type: 'host_register',
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
      broadcast host
    end
  end
end

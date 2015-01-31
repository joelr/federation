class HostBroadcaster

  def self.broadcast host, method = 'host_register'
    FederationBroadcaster.hosts_for_broadcast.each do |host|
      r = FederationBroadcaster.publish_to_host({
        type: method,
        data: {
          host: host.host,
          name: host.name,
          url: host.url,
          charity_id: host.charity_id,
        }
      }, host)
      if r.presence && r["hosts"]
        r["hosts"].each do |payload|
          puts "ADDING A HOST? #{payload.inspect}"
          payload = payload.as_json.symbolize_keys.slice :host, :url, :charity_id, :name
          Host.build_from_payload payload
        end
      end
    end
  end

  def self.broadcast_local
    Host.local_hosts.each do |host|
      data = broadcast host, 'host_register'
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

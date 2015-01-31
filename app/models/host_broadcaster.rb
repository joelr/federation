class HostBroadcaster

  def self.broadcast host, method = 'host_register', custom_host = nil
    FederationBroadcaster.hosts_for_broadcast.each do |host|
      puts "broadcasting?"
      puts host.inspect
      host_to_publish = custom_host || host
      r = FederationBroadcaster.publish_to_host({
        type: method,
        data: {
          host: host_to_publish.host,
          name: host_to_publish.name,
          url: host_to_publish.url,
          charity_id: host_to_publish.charity_id,
          has_email: host_to_publish.has_email
        }
      }, host)
      if r.presence && r["hosts"]
        r["hosts"].each do |payload|
          puts "ADDING A HOST? #{payload.inspect}"
          payload = payload.as_json.symbolize_keys.slice :host, :url, :charity_id, :name, :has_email
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
      Host.local_hosts.each do |host|
        broadcast host, 'discover', host
      end
    end
  end
end

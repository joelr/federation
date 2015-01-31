class FederationBroadcaster

  def self.publish payload
    hosts_for_broadcast.each do |host|
      result = HTTParty.post("#{host.path}/#{payload[:type]}", 
        body: payload[:data].to_json,
        headers: { 'Content-Type' => 'application/json' }
      )
      puts result.body
    end
  end

  def self.hosts_for_broadcast publish_local = true
    local_hosts = Host.local_hosts.collect(&:host).collect(&:downcase)
    if !publish_local
      Host.all.reject{ |host| local_hosts.include?(host.host.downcase) }
    else
      Host.all + Host.local_hosts
    end
  end
end

class FederationBroadcaster

  def self.publish payload
    hosts_for_broadcast.each do |host|
      puts host.inspect
      puts "#{host.url}/api/v1/#{payload[:type]}".inspect
      result = HTTParty.post("#{host.url}/api/v1/#{payload[:type]}", 
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
      Host.all.to_a + Host.local_hosts
    end
  end
end

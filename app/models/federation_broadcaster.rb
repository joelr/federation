class FederationBroadcaster

  def self.publish payload
    hosts_for_broadcast.each do |host|
      publish_to_host payload, host
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

  private

  def self.publish_to_host payload, host
    begin
      result = HTTParty.post("#{host.url}/api/v1/#{payload[:type]}", 
        body: payload[:data].to_json,
        headers: { 'Content-Type' => 'application/json' }
      )
      Hashie::Mash.new(JSON.parse(result.body))
    rescue Errno::ECONNREFUSED
      puts "#{host.url}/api/v1/#{payload[:type]} FAILED".inspect
    end
  end
end

class Host < ActiveRecord::Base

  def self.build_from_payload params
    actual_host = host_from_url(params[:url])
    host = Host.where(host: actual_host).first_or_initialize
    puts host.inspect
    puts puts params.inspect 
    host.update_attributes params
  end

  def self.local_hosts
    data_file = Rails.root.join 'config', 'hosts.yml'

    YAML.load_file(data_file).map do |_, attributes|
      Host.new attributes
    end
  end

  def path
    "http://#{host}:#{port}/api/v1"
  end

  def port
    Rails.env.development?? 3000 : 80
  end

  def self.host_from_url url
    url.downcase.split("://").last.split(":").first
  end

end
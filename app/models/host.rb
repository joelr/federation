class Host < ActiveRecord::Base
  attr_accessor :password

  def self.build_from_payload params
    actual_host = host_from_url(params[:url])
    host = Host.where(host: actual_host).first_or_initialize
    puts host.inspect
    puts puts params.inspect 
    host.update_attributes params
  end

  def self.find_local host
    local_hosts.select{|h| h.host == host.downcase}.first
  end

  def self.local_hosts
    data_file = Rails.root.join 'config', 'hosts.yml'

    YAML.load_file(data_file).map do |_, attributes|
      h = Host.new attributes
      h
    end
  end

  def self.host_from_url url
    url.downcase.split("://").last.split(":").first
  end

  def authenticate pass
    password == pass
  end

end
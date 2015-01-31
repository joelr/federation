class Host < ActiveRecord::Base
  attr_accessor :password

  def self.build_from_payload params
    actual_host = host_from_url(params[:url])
    host = Host.where(host: actual_host).first_or_initialize
    host.update_attributes params
  end

  def self.add_host host
    actual_url = url_from_host(host)
    actual_host = host_from_url(host)
    host = Host.where(host: actual_host).first_or_initialize
    host.update_attributes url: actual_url
  end

  def self.find_host host
    Host.where(host: host.downcase).first
  end

  def self.find_local host
    local_hosts.select{|h| h.host == host.downcase}.first
  end

  def self.local_hosts
    if Rails.env.development?
      data_file = Rails.root.join 'config', 'local_hosts.yml'
    else
      data_file = Rails.root.join 'config', 'hosts.yml'
    end

    YAML.load_file(data_file).map do |_, attributes|
      h = Host.new attributes
      h
    end
  end

  def self.host_from_url url
    url.downcase.split("://").last.split(":").first
  end

  def self.url_from_host host
    if host.include?("://")
      host
    else
      if Rails.env.development?
        "http://#{host}:5000"
      else
        "http://#{host}"
      end
    end
  end

  def authenticate pass
    password == pass
  end

end
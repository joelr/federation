class Host < ActiveRecord::Base

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

end
require 'active_support/concern'

module Apiable
  extend ActiveSupport::Concern


  def api_get host_string, path, body = {}
    h = Host.where(host: host_string.downcase).first
    req = HTTParty.get("#{h.url}/api/v1/#{path}?#{body.to_query}")
    Hashie::Mash.new JSON.parse(req.body)
  end
end
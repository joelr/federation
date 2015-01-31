require 'active_support/concern'

module Apiable
  extend ActiveSupport::Concern


  def api_get host_string, path, body = {}, auth = {}
    if host_string.include?("http")
      h = nil
    else
      h = Host.where(host: host_string.downcase).first
    end
    url = if h
      h.url
    else
      host_string
    end
    req = HTTParty.get("#{url}/api/v1/#{path}?#{body.to_query}", basic_auth: auth)
    Hashie::Mash.new JSON.parse(req.body)
  end
end
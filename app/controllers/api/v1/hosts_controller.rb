class Api::V1::HostsController < ApplicationController

  def register
    #host = Host.where(host: params)
    Host.build_from_payload host_params
    render json: {hosts: Host.all}
  end

  def host_params
    params.symbolize_keys.slice :host, :url, :paypal_email, :charity_id
  end
end
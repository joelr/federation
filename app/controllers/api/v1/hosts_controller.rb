class Api::V1::HostsController < ApplicationController
  before_filter :basic_auth, only: [:index, :local]

  def index
    render json: Host.all
  end

  def local
    render json: localhost
  end

  def register
    Host.build_from_payload host_params
    render json: {hosts: Host.all}
  end

  def discover
    Host.build_from_payload host_params
    render_ok
  end

  def host_params p = nil
    p ||= params
    p.symbolize_keys.slice :host, :url, :paypal_email, :charity_id, :name
  end
end

class Api::V1::HostsController < ApplicationController
  before_filter :basic_auth, only: [:index, :local, :add]

  def index
    hosts = Host.all
    hosts = hosts.map {|host|
      host.localhost = localhost
      host
    }
    render json: hosts
  end

  def local
    render json: localhost
  end

  def add
    Host.add_host params[:host]
    render_ok
    HostBroadcaster.broadcast_local
  end

  def register
    Host.build_from_payload host_params
    render json: Host.all, each_serializer: PrivateHostSerializer
  end

  def discover
    Host.build_from_payload host_params
    render_ok
  end

  def host_params p = nil
    p ||= params
    p.symbolize_keys.slice :host, :url, :charity_id, :name, :has_email
  end
end

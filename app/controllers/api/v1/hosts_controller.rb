class Api::V1::HostsController < ApplicationController

  def register
    #host = Host.where(host: params)
    render json: params
  end
end
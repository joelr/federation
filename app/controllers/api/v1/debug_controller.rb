class Api::V1::DebugController < ApplicationController
  before_filter :basic_auth

  def clear
    Host.reset_all
    render_ok
  end

  def broadcast
    HostBroadcaster.broadcast_local
    render_ok
  end

end
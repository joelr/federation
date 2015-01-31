class AppController < ApplicationController
  def index
    render json: {hosts: Host.all}
  end
end

class Api::V1::MessagesController < ApplicationController
  before_filter :basic_auth, except: 'receive'

  def index
    render json: {messages: Messages.all}
  end

  def create
    puts create_params.inspect
    Messages::Broadcast.publish localhost, create_params
    render_ok
  end

  def receive
    Message.build_from_payload receive_params
    render_ok
  end

  def receive_params
    params.symbolize_keys.slice :text, :sender_host, :host, :type, :filter, :uuid
  end

  def create_params
    params.symbolize_keys.slice :text, :host, :filter
  end
end

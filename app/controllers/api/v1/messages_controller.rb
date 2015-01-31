class Api::V1::MessagesController < ApplicationController
  before_filter :basic_auth, except: 'receive'

  def index
    render json: Message.limit(50).order("id desc"), each_serializer: MessageSerializer
  end

  def create
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

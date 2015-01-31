class Api::V1::MessagesController < ApplicationController
  before_filter :basic_auth, except: [:receive, :validate]

  def index
    mess = messages.map{|m|
      m.localhost = localhost
      m
    }
    render json: mess, each_serializer: MessageSerializer
  end

  def create
    Messages::Broadcast.publish localhost, create_params
    render_ok
  end

  def receive
    if receive_params[:sender_host] == localhost.host
      render_error
    else
      Message.build_from_payload receive_params
      render_ok
    end
  end

  def validate
    if Message.find_and_validate params[:uuid], params[:checksum]
      render_ok
    else
      render_error
    end
  end

  def receive_params
    params.symbolize_keys.slice :text, :sender_host, :host, :type, :filter, :uuid
  end

  def create_params
    params.symbolize_keys.slice :text, :host, :filter, :password
  end


  def messages
    scope = Message.all
    if params[:since]
      scope = scope.where("created_at > ?", DateTime.parse(params[:since]))
    end
    if params[:hosts].presence
      scope.where(sender_host: params[:hosts].split(",")).limit(50).order("id desc")
    else
      scope.limit(50).order("id desc")
    end
  end
end

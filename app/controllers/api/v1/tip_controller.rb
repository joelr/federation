class Api::V1::TipController < ApplicationController
  before_filter :basic_auth, only: [:request_email]

  def request_email
    TipRequester.new(localhost).request_email_from_host host
    render_ok
  end

  def send_email
    TipRequester.new(localhost).send_email_to_host host
    render_ok
  end

  def inbound_email_request
    TipRequester.new(localhost).send_email_to_host host
    render_ok
  end

  def inbound_email_response
    host.update_attributes paypal_email: params[:email]
    host.save
    render_ok
  end

  private

  def host
    @host ||= Host.find_host(params[:host])
  end
end

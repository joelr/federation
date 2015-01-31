class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token

  def render_ok
    render json: {status: 'ok'}
  end

  def localhost
    @localhost ||= Host.find_local(request.host)
  end

  def basic_auth
    if user = authenticate_with_http_basic { |u, p| localhost.authenticate(p) }
    else 
     request_http_basic_authentication
    end
  end
end

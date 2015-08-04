class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  before_action :authenticate#, except: [:show, :index]

  protected

  def authenticate
    if ActionController::HttpAuthentication::Basic.has_basic_credentials?(request)
      authenticate_or_request_with_http_basic do |email, password|
        user = User.find_by(email: email)
        if user.try(:authenticate, password)
          @current_user = user
        else
          self.headers["WWW-Authenticate"] = %(Basic realm="Application", Token realm="Application")
        end
      end
    end

  end

end

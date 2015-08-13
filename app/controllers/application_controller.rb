class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include Pundit
  before_action :current_user

  protected

  def current_user
    if ActionController::HttpAuthentication::Basic.has_basic_credentials?(request)
      authenticate_or_request_with_http_basic do |email, password|
        user = User.find_by(email: email)
        if user.try(:authenticate, password)
          return user
        else
          self.headers["WWW-Authenticate"] = %(Basic realm="Application", Token realm="Application")
        end
      end
    end
    User.guest.new
  end

end

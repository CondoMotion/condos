class ApplicationController < ActionController::Base
  protect_from_forgery

private
  def current_role
  	@current_role ||= current_user.email if current_user
  end
  helper_method :current_role

end

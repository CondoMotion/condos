class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

private
  def current_role
  	# UPDATE THIS METHOD TO DETERMINE CURRENT ROLE FOR THE USER
  	if user_signed_in?
  		@current_role ||= :admin 
  	else
  		@current_role ||= :guest
  	end
  end
  helper_method :current_role

  def current_ability
	  @current_ability ||= Ability.new(current_role)
	end

end

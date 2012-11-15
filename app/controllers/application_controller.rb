class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    sites_path
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

private
  def load_site
    @site = Site.find_by_subdomain!(request.subdomain)
  end

  def current_company
    if current_user && current_user.owned_company
      @current_company = current_user.owned_company
    elsif current_user && current_user.company
      @current_company = current_user.company
    else
      @current_company = nil
    end
  end
  helper_method :current_company

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
	  @current_ability ||= Ability.new(current_role, current_user, current_company)
	end

end

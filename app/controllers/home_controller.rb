class HomeController < ApplicationController
	def index
		if user_signed_in? 
			@company = current_user.owned_company
		end
	end

	def pricing
		
	end

	def about
		
	end

	def contact
		
	end
end

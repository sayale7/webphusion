class HomeController < ApplicationController
  protect_from_forgery
  layout 'application'

	def index
		unless request.url.include?('webphusion.com')
			redirect_to "http://#{request.domain}/pages/86"
		end
	end
end

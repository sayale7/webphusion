class HomeController < ApplicationController
	protect_from_forgery
	layout 'application'

	def index
		unless request.url.include?('webphusion.com')
			user = User.find_by_domain(request.domain.to_s)
			unless user.nil?
				redirect_to "http://#{request.domain}/pages/#{user.id}"
				#website = Website.find_by_user_id(user.id)
				# unless website.nil?
				# 					redirect_to "http://#{request.domain}/pages/#{website.start_page_id}"
				# 				end
			end
		end
	end
end

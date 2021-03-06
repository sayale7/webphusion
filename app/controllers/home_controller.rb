class HomeController < ApplicationController
	protect_from_forgery
	layout 'application'

	def index
		unless request.url.include?('webphusion.com') #and request.url.port.to_s.eql?('3000')
			user = User.find_by_domain(request.domain.to_s)
			unless user.nil?
				redirect_to "http://#{request.domain}/pages/#{Website.find_by_user_id(user.id).start_page_id}"
				#website = Website.find_by_user_id(user.id)
				# unless website.nil?
				# 					redirect_to "http://#{request.domain}/pages/#{website.start_page_id}"
				# 				end
			end
		end
	end
end

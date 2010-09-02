class HomeController < ApplicationController
	protect_from_forgery
	layout 'application'

	def index
		unless request.url.include?('webphusion.com')
			user = User.find_by_domain(request.domain.to_s).id
			page = ""
			unless user.nil?
				website = Website.find_by_user_id(user.id)
				unless website.nil?
					page = Page.current_page = website.start_page_id
				end
			end
			unless page.to_s.eql?('')
				redirect_to "http://#{request.domain}/pages/#{page}"
			else
				redirect_to "http://webphusion.com"
			end
		end
	end
end

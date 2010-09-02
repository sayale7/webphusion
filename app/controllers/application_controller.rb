class ApplicationController < ActionController::Base
  rescue_from ActionController::RoutingError, :with => :route_not_found
  rescue_from ActionController::MethodNotAllowed, :with => :invalid_method
	before_filter :get_domain, :set_current_theme_for_model, :set_current_page_for_show, :set_locale
  
  include UrlHelper
  protect_from_forgery
  layout 'application'
	helper_method :get_locale
	
	def get_domain
		unless request.url.include?('webphusion.com')
			redirect_to "http://#{request.domain}/pages/86"
		end
	end

	def set_current_theme_for_model   
		if request.subdomains.empty?
			Theme.current_theme = params[:theme_id] rescue nil
		else
			user = User.find_by_subdomain(request.subdomains.last.to_s)
			unless user.nil?
				if params[:id].nil?
					website = Website.find_by_user_id(user.id)
					page = Page.find(website.start_page_id)
					Theme.current_theme = Theme.find(page.theme_id).id
				else
					page = Page.find(params[:id])
					Theme.current_theme = Theme.find(page.theme_id).id
				end
			else
				if request.port.to_s.eql?('3000')
					redirect_to "http://#{request.domain}:#{request.port}"
				else
					redirect_to "http://#{request.domain}"
				end
			end
		end
	end
	
	def set_current_page_for_show
		unless request.subdomains.empty?
			unless params[:id].nil?
				Page.current_page = params[:id] rescue nil
			else
				Page.current_page = Website.find_by_user_id(User.find_by_subdomain(request.subdomains.last.to_s).id).start_page_id
			end
		end
	end

	def set_locale
	  # if params[:locale] is nil then I18n.default_locale will be used
	  I18n.locale = request.subdomains.first.to_s.length == 2 ? request.subdomains.first.to_s : I18n.default_locale  
		Page.current_locale = I18n.locale
	end
	
  private
	
	def get_locale
     I18n.locale
  end
  
  # rescue_from ActiveRecord::RecordNotFound do |exception|
  #   flash[:error] = "Daten konnten nicht gefunden werden"
  #   redirect_to root_url
  # end
  
  def route_not_found
    render :text => 'Na, nach was schauen Sie denn?', :status => :not_found
  end
  
  def invalid_method
    message = "Now, did your mom tell you to do that ?"
    render :text => message, :status => :method_not_allowed
  end
  

  
end

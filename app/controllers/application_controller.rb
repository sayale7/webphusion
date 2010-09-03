class ApplicationController < ActionController::Base
  rescue_from ActionController::RoutingError, :with => :route_not_found
  rescue_from ActionController::MethodNotAllowed, :with => :invalid_method
	before_filter :set_current_theme_for_model, :set_current_page_for_show, :set_locale
  
  include UrlHelper
  protect_from_forgery
  layout 'application'
	helper_method :get_locale

	def set_current_theme_for_model 
		#wenn 
		if request.subdomains.empty?
			get_theme_by_domain_name
		elsif request.subdomains.size == 1 and request.subdomains.first.to_s.length == 2 and !(request.domain.to_s.eql?('webphusion.com') or request.domain.to_s.eql?('lvh.me'))
			get_theme_by_domain_name
		elsif request.subdomains.size == 1 and request.subdomains.first.to_s.length == 2 and (request.domain.to_s.eql?('webphusion.com') or request.domain.to_s.eql?('lvh.me'))
		
		else
			get_theme_by_subdomain
		end
	end
	
	def set_current_page_for_show
		#Configuration for development Mode
		if request.port.to_s.eql?('3000') and request.subdomains.empty?
			unless params[:id].nil?
				Page.current_page = params[:id] rescue nil
			else
				user = User.find_by_domain(request.domain.to_s).id
				unless user.nil?
					website = Website.find_by_user_id(user.id)
					unless website.nil?
						Page.current_page = website.start_page_id
					end
				end
			end
			
		#Configuration for own domain
		elsif request.subdomains.empty?
			unless params[:id].nil?
				Page.current_page = params[:id] rescue nil
			else
				user = User.find_by_domain(request.domain.to_s).id
				unless user.nil?
					website = Website.find_by_user_id(user.id)
					unless website.nil?
						Page.current_page = website.start_page_id
					end
				end
			end
			
		#Configuration own domain and languages
		elsif request.subdomains.size == 1 and request.subdomains.first.to_s.length == 2 and !(request.domain.to_s.eql?('webphusion.com') or request.domain.to_s.eql?('lvh.me'))
			unless params[:id].nil?
				Page.current_page = params[:id] rescue nil
			else
				user = User.find_by_domain(request.domain.to_s).id
				unless user.nil?
					website = Website.find_by_user_id(user.id)
					unless website.nil?
						Page.current_page = website.start_page_id
					end
				end
			end
		
		#Configuration for the application -> no page show
		elsif request.subdomains.size == 1 and request.subdomains.first.to_s.length == 2 and (request.domain.to_s.eql?('webphusion.com') or request.domain.to_s.eql?('lvh.me'))
		
		
		#get pages by subdomain
		else
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
	
	def get_theme_by_domain_name
		user = User.find_by_domain(request.domain.to_s)
		unless user.nil?
			if params[:id].nil?
				website = Website.find_by_user_id(user.id)
				page = Page.find(website.start_page_id)
				Theme.current_theme = Theme.find(page.theme_id).id
			else
				page = Page.find(params[:id])
				Theme.current_theme = Theme.find(page.theme_id).id
			end
		end
	end
	
	def get_theme_by_subdomain
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
	
	def get_page_by_domain_name
		unless params[:id].nil?
			Page.current_page = params[:id] rescue nil
		else
			user = User.find_by_domain(request.domain.to_s).id
			unless user.nil?
				website = Website.find_by_user_id(user.id)
				unless website.nil?
					Page.current_page = website.start_page_id
				end
			end
		end
	end

	def get_page_by_subdomain
		unless params[:id].nil?
			Page.current_page = params[:id] rescue nil
		else
			Page.current_page = Website.find_by_user_id(User.find_by_subdomain(request.subdomains.last.to_s).id).start_page_id
		end
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

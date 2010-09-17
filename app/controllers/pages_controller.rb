class PagesController < ApplicationController

	respond_to :html, :js
	layout '/layouts/pages'	

	def index
		if request.url.include?('page_ids')
			params[:page_ids].each_with_index do |page_id, index|
				Page.find(page_id).update_attribute(:position, index)
			end
			redirect_to '/pages?parent=none'
		else
			parent = ""
			if params[:parent] == "none"
				parent = nil
			else
				parent = params[:parent]
			end
			if current_user.themes.empty?
				flash[:info] = t('page.no_template')
				redirect_to themes_url
			else
				@pages = current_user.pages.find_all_by_parent_id(parent, :order => 'position')
				render :layout => '/layouts/application'
			end
		end
	end
  
  def show
		if request.subdomains.empty?
			get_page_by_domain_name
		elsif !request.domain.to_s.eql?('webphusion.com') and !request.domain.to_s.eql?('lvh.me')
			get_page_by_domain_name
		else
			get_page_by_subdomain_name
		end	
		render :layout => '/layouts/user_layout'
  end
  
  def new
    @page = Page.new
		render :layout => '/layouts/popup'
  end
  
  def create
    @page = Page.new(params[:page])
		@page.position = current_user.pages.find_all_by_parent_id(@page.parent_id).size
		@page.manage_locales(params[:page][:languages])
    if @page.save
    	@pages = current_user.pages.find_all_by_parent_id(nil)
      render :template => '/pages/index'
    else
      render :action => 'new'
    end
  end
  
  def edit
    @page = Page.find(params[:id])
		render :layout => '/layouts/popup'
  end
  
  def update
    @page = Page.find(params[:id])
		@theme = Theme.find(@page.theme_id)
		different_level = @page.parent_id.to_s.eql?(params[:page][:parent_id].to_s)
		unless different_level
			update_postions_in_old_level
		end
		@page.update_attributes(params[:page])
		unless different_level
			@page.update_attribute(:position, current_user.pages.find_all_by_parent_id(@page.parent_id).size - 1)
		end
    @pages = current_user.pages.find_all_by_parent_id(nil, :order => 'position')
		@page.manage_locales(params[:languages])
    render :template => '/pages/index'
  end
  
  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    redirect_to pages_url
  end

	def reorder_pages
		unless params[:parent].to_s.eql?('none')
			@pages = current_user.pages.find_all_by_parent_id(params[:parent], :order => 'position')
		else
			@pages = current_user.pages.find_all_by_parent_id(nil, :order => 'position')
		end
		render :layout => '/layouts/application'
	end

	# def add_item_to_page
	# 	@page = Page.find(params[:page].to_s)
	# 	theme_item = ThemeItem.find(params[:item].to_s)
	# 	@theme = Theme.find(theme_item.theme_id)
	# 	item = Item.find_or_create_by_page_id_and_theme_item_id(@page.id, theme_item.id)
	# 	item.update_attribute(:active, true)
	# 	redirect_to edit_page_url(@page)
	# end
	# 
	# def remove_item_from_page
	# 	@page = Page.find(params[:page].to_s)
	# 	theme_item = ThemeItem.find(params[:item].to_s)
	# 	@theme = Theme.find(theme_item.theme_id)
	# 	item = Item.find(params[:the_item].to_s)
	# 	if item.update_attribute(:active, false)
	# 		redirect_to edit_page_url(@page)
	# 	end
	# end

	private
	
	def update_postions_in_old_level
		pages = current_user.pages.find_all_by_parent_id(@page.parent_id, :order => 'position') - @page.to_a
		pages.each_with_index do |page, index|
			page.update_attribute(:position, index)
		end
	end
	
	def create_items_for_theme
		Theme.find(@page.theme_id).theme_items.each do |theme_item|
			Item.find_or_create_by_theme_item_id_and_page_id(theme_item.id, @page.id)
		end
	end
	
	def update_items_for_theme
		Theme.find(@page.theme_id).theme_items.each do |theme_item|
			Item.find_or_create_by_theme_item_id_and_page_id(theme_item.id, @page.id)
		end
	end
	
	def get_page_by_domain_name
		domain_string = request.domain.to_s
		unless params[:id].nil?
			@page = User.find_by_domain(domain_string).pages.find(params[:id])
		else
			@page = User.find_by_domain(domain_string).pages.first
		end
		@pages = User.find_by_domain(domain_string).pages.find_all_by_active_and_parent_id(true, nil, :order => 'position')
	end
	
	def get_page_by_subdomain_name
		subdomain_string = request.subdomains.last.to_s
		unless params[:id].nil?
			@page = User.find_by_subdomain(subdomain_string).pages.find(params[:id])
		else
			@page = User.find_by_subdomain(subdomain_string).pages.first
		end
		@pages = User.find_by_subdomain(subdomain_string).pages.find_all_by_active_and_parent_id(true, nil, :order => 'position')
	end
end

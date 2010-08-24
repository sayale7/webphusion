class ThemesController < ApplicationController
	
	respond_to :html, :js
	layout  '/layouts/themes'
	
	def index
		@users = User.all
		render :layout => '/layouts/application'
	end
	
	def new
		@theme = Theme.new
		render :layout => '/layouts/popup'
	end
	
	def create
		@theme = Theme.new(params[:theme])
		@theme.save
		@users = User.all
		render :layout => '/layouts/themes'
		# redirect_to themes_path
	end
	
	def edit
		if current_user.admin == true
			@theme = Theme.find(params[:id])
		else
			@theme = current_user.themes.find(params[:id])
		end
	end
	
	def update
		if current_user.admin == true
			@theme = Theme.find(params[:id])
		else
			@theme = current_user.themes.find(params[:id])
		end
		@theme.update_attributes(params[:theme])
		render :template => '/themes/update'  # redirect_to edit_theme_path(@theme)
	end
	
	def destroy
		theme = Theme.find(params[:id])
		if theme.destroy_if_empty?
			theme.destroy
			redirect_to themes_url
		else
			flash[:info] = t('messages.cannot_destroy_theme')
			redirect_to edit_theme_url(theme)
		end
	end
	
	def upload_files_eiditing
		@theme = Theme.find(params[:theme_id])
		the_file = ThemeUpload.find_by_theme_file_file_name_and_theme_id(params[:name].to_s, params[:theme_id].to_s)
		@the_path = the_file.theme_file.path
		@content = File.new(@the_path).read
	end
	
	def upload_files_update
		the_file = File.open(params[:the_path], 'w')
		the_file.puts params[:file_edit]
		redirect_to "/upload_files_eiditing?theme_id=#{params[:theme]}&name=#{the_file.original_filename}"
	end
	
end
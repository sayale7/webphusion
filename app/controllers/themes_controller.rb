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
		render :template => '/themes/update'  
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
		if params[:content_length]
			until File.new(@the_path).read.length.to_s.eql?(params[:content_length].to_s)
			end
		end
		@mime_type = the_file.theme_file_content_type
		@file_name = the_file.theme_file_file_name
		@content = File.new(@the_path).read
	end
	
	def upload_files_update
		
		the_filename = ""
		if params[:file_name].include?('.')
			the_filename = params[:file_name].split('.').first
		else
			the_filename = params[:file_name]
		end
		
		exists = false
		
		ThemeUpload.find_all_by_theme_id(params[:theme]).each do |file|
			if the_filename.to_s.eql?(file.theme_file_file_name.split('.').first)
			 	exists = true
			end
		end
		
		unless exists
			the_file = File.open(params[:the_path], 'w')
			the_file.write(params[:file_edit])
			old_path = params[:the_path]
			theme_file = ThemeUpload.find_by_theme_id_and_theme_file_file_name(params[:theme], the_file.original_filename)
			new_path = params[:the_path][0, old_path.length - the_file.original_filename.length] << the_filename << file_name_update(theme_file)
			theme_file.theme_file_file_name = the_filename << file_name_update(theme_file)
			theme_file.save
			File.rename(old_path, new_path)
			redirect_to "/upload_files_eiditing?theme_id=#{params[:theme]}&name=#{theme_file.theme_file_file_name}&content_length=#{params[:file_edit].to_s.length}"
		else
			redirect_to "/upload_files_eiditing?theme_id=#{params[:theme]}&name=#{File.open(params[:the_path], 'w').original_filename}&content_length=#{params[:file_edit].to_s.length}"
		end
		
	end
	
	def file_name_update(theme_file)
		file_ending = ""
		if theme_file.theme_file_content_type.to_s.eql?('application/javascriptapplication/x-javascript')
			file_ending << '.js'
		elsif theme_file.theme_file_content_type.to_s.eql?('text/css')
			file_ending << '.css'
		end
		return file_ending
	end
	
end
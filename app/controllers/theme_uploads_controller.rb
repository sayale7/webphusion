class ThemeUploadsController < ApplicationController

	respond_to :html, :js

	def index
		@delete_hash = Hash.new
		@theme = Theme.find(params[:theme_id])
		@theme_uploads = @theme.theme_uploads
		render :layout => '/layouts/iframe_popup'
	end

	def upload_theme_files
		user = User.find(current_user)
		newparams = coerce(params)
		theme_upload = ThemeUpload.new(newparams[:theme_upload])
		@theme = Theme.find(theme_upload.theme_id)
		theme_upload.save
		@theme_uploads = Theme.find(theme_upload.theme_id).theme_uploads
		render :template => '/theme_uploads/index'
	end

	def destroy
		theme_upload = ThemeUpload.find(params[:id])
		theme_id = theme_upload.theme_id
		theme_upload.destroy
		redirect_to "/theme_uploads?theme_id=#{theme_id}"
	end

	def destroy_selected
		ThemeUpload.destroy_all(:id => params[:theme_upload_ids])
		redirect_to theme_uploads_path(:theme_id => params[:theme_id])
	end
	
	def new
		@theme_upload = ThemeUpload.new
		@theme_id = params[:theme_id]
		@theme = Theme.find(@theme_id)
		render :layout => 'popup'#'themes'
	end
	
	def create
		theme_upload = ThemeUpload.new
		the_filename = ''
		
		if params[:theme_upload][:theme_file_file_name].include?('.')
			the_filename = params[:theme_upload][:theme_file_file_name].split('.').first
		else
			the_filename = params[:theme_upload][:theme_file_file_name]
		end
		
		exists = false
		ThemeUpload.find_all_by_theme_id(params[:theme_upload][:theme_id]).each do |file|
			if the_filename.to_s.eql?(file.theme_file_file_name.split('.').first)
			 	exists = true
			end
		end
		
		unless exists
			theme_upload.theme_id = params[:theme_upload][:theme_id]
			theme_upload.theme_file = File.new(the_filename, "w+")
			theme_upload.theme_file_content_type = params[:theme_upload][:theme_file_content_type]
			if params[:theme_upload][:theme_file_content_type].to_s.eql?('application/javascriptapplication/x-javascript')
				theme_upload.theme_file_file_name = theme_upload.theme_file_file_name << '.js'
			elsif params[:theme_upload][:theme_file_content_type].to_s.eql?('text/css')
				theme_upload.theme_file_file_name = theme_upload.theme_file_file_name << '.css'
			end
			File.delete("#{Rails.root}/#{theme_upload.theme_file_file_name.split('.').first}")
			if theme_upload.save
				redirect_to upload_files_eiditing_path(:theme_id => theme_upload.theme_id, :name => theme_upload.theme_file.original_filename)
			else
				redirect_to edit_theme_path(theme_path.theme_id)
			end
		else
			redirect_to edit_theme_path(params[:theme_upload][:theme_id]) 
		end
	end
	
	
	def destroy
		
	end

	private 

	def coerce(params)
		if params[:video].nil? 
			h = Hash.new 
			h[:theme_upload] = Hash.new 
			h[:theme_upload][:theme_id] = params[:theme_id]
			h[:theme_upload][:theme_file] = params[:Filedata]
			h[:theme_upload][:theme_file].content_type = MIME::Types.type_for(h[:theme_upload][:theme_file].original_filename).to_s
			h
		else 
			params
		end 
	end
end
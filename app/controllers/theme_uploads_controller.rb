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
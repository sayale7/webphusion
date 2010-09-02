class CommonFilesController < ApplicationController

	respond_to :html, :js

	def index
		@delete_hash = Hash.new
		@common_files = current_user.common_files
		render :layout => '/layouts/iframe_popup'
	end

	def upload_common_files
		user = User.find(current_user)
		newparams = coerce(params)
		common_file = CommonFile.new(newparams[:common_file])
		common_file.save
		@common_files = current_user.common_files
		render :template => '/common_files/index'
	end

	def destroy
		video = Video.find(params[:id])
		video.destroy
		redirect_to '/videos'
	end

	def destroy_selected
		CommonFile.destroy_all(:id => params[:common_file_ids])
		redirect_to common_files_path
	end

	private 

	def coerce(common_file)
		if params[:video].nil? 
			h = Hash.new 
			h[:common_file] = Hash.new 
			h[:common_file][:user_id] = current_user.id
			h[:common_file][:asset_file] = params[:Filedata]
			h[:common_file][:asset_file].content_type = MIME::Types.type_for(h[:common_file][:asset_file].original_filename).to_s
			h
		else 
			params
		end 
	end
end
class AssetsController < ApplicationController
  
	respond_to :html, :js

  def index
  	@delete_hash = Hash.new
		if params[:collection_id]
			@assets = Asset.find_all_by_collection_id(params[:collection_id])
			@collection_id = params[:collection_id]
		else
			@assets = current_user.assets.find_all_by_collection_id(nil)			
			@collection_id = nil
		end
		render :layout => '/layouts/popup', :template => '/assets/index'
  end

	def upload_assets
		user = User.find(current_user)
		newparams = coerce(params)
		asset = Asset.new(newparams[:asset])
		asset.save
		@assets = current_user.assets
		render :template => '/assets/index'
	end
	
	# def show
	# 	index
	# end
	
	def destroy
		asset = Asset.find(params[:id])
		asset.destroy
		redirect_to '/assets'
	end
	
	def destroy_selected
		the_collection = Asset.find(params[:asset_ids].first).collection_id
		Asset.destroy_all(:id => params[:asset_ids])
		if the_collection.nil?
			redirect_to assets_path
		else
			redirect_to assets_path(:collection_id  => the_collection)
		end
	end
	
	private 
	
	def coerce(params)
		if params[:asset].nil? 
			h = Hash.new 
			h[:asset] = Hash.new 
			h[:asset][:collection_id] = params[:collection_id]
			h[:asset][:user_id] = current_user.id
			h[:asset][:image] = params[:Filedata]
			h[:asset][:image].content_type = MIME::Types.type_for(h[:asset][:image].original_filename).to_s
			h
		else 
			params
		end 
	end
end
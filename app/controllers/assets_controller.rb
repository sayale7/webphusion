class AssetsController < ApplicationController
  
	respond_to :html, :js

  def index
  	@delete_hash = Hash.new
		if params[:collection_id]
			@assets = Asset.find_all_by_collection_id_and_parent_id(params[:collection_id], params[:parent_id], :order => 'position')
			@collection_id = params[:collection_id]
			@parent_id = params[:parent_id]
		else
			@assets = current_user.assets.find_all_by_collection_id(nil, :order => 'position')			
			@collection_id = nil
			@parent_id = nil
		end
		render :layout => '/layouts/iframe_popup', :template => '/assets/index'
  end

	def update_asset_order
		  page_id = Page.find(Item.find(Asset.find(params[:asset_ids].first).collection_id).page_id).id
			params[:asset_ids].each_with_index do |asset_id, index|
				Asset.find(asset_id).update_attribute(:position, index)
			end
			redirect_to "/edit_content?page_id=#{page_id}"
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
		the_parent_id = Asset.find(params[:asset_ids].first).parent_id
		Asset.destroy_all(:id => params[:asset_ids])
		if the_collection.nil?
			redirect_to assets_path
		else
			redirect_to assets_path(:collection_id  => the_collection, :parent_id => the_parent_id)
		end
	end
	
	def reorder_assets
		parent_id = params[:parent_id] == nil ? nil : params[:parent_id]
		@assets = Asset.find_all_by_collection_id_and_parent_id(params[:collection_id], parent_id, :order => 'position')
	end
	
	
	def edit
		@asset = Asset.find(params[:id])
		@asset_description = Description.find_by_descriptionable_type_and_descriptionable_id_and_language('Asset', @asset.id, params[:language].to_s)
	end
	
	def update
		asset = Asset.find(params[:id])
		description = Description.find_by_descriptionable_type_and_descriptionable_id_and_language('Asset', asset.id, params[:language].to_s)
		description.update_attribute(:content, params[:description])
		redirect_to "/edit_content?from_asset=#{asset.id}"
	end
	
	private 
	
	def coerce(params)
		if params[:asset].nil? 
			h = Hash.new 
			h[:asset] = Hash.new 
			h[:asset][:collection_id] = params[:collection_id]
			h[:asset][:parent_id] = params[:parent_id]
			h[:asset][:position] = Asset.find_all_by_collection_id_and_parent_id(params[:collection_id], params[:parent_id]).size
			h[:asset][:user_id] = current_user.id
			h[:asset][:image] = params[:Filedata]
			h[:asset][:image].content_type = MIME::Types.type_for(h[:asset][:image].original_filename).to_s
			h
		else 
			params
		end 
	end
end
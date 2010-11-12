class ItemDatasController < ApplicationController
	
	layout 'popup'
	
	def new_content
		@item_data_content = ItemDataContent.new
	end
	
	def create_content
		@item_data_content = ItemDataContent.new(params[:item_data_content])
		@item_data_content.save
		@page = @item_data_content.item.page
		render :template => '/item_datas/ajax'
		#redirect_to edit_page_path(@item_data_content.item_data.page.id)
	end
	
	def edit_content
		#go from pages index to edit page content
		if params[:page_id]
			@page = Page.find(params[:page_id])
		#load some textual content
		elsif params[:content_id]
			@item_data_content = ItemDataContent.find(params[:content_id])
			@page = @item_data_content.item.page
		#load a theme item like a image gallery
		elsif params[:item_id]
			@item = Item.find(params[:item_id])
			@page = Page.find(@item.page_id)
		elsif params[:from_asset]
			@item = Item.find(Asset.find(params[:from_asset]).collection_id)
			@page = Page.find(@item.page_id)
			@click = "true"
		elsif params[:simple_item_id]
			@simple_item = ItemDataContent.find(params[:simple_item_id])
			@page = @simple_item.item.page
		end
		render :layout => '/layouts/pages'
	end
	
	def update_content
		@item_data_content = ItemDataContent.find(params[:id])
		@item_data_content.update_attributes(params[:item_data_content])
		@simple_item = @item_data_content
		@page = @item_data_content.item.page
		render :template => '/item_datas/edit_content'
		#redirect_to edit_page_path(@item_data_content.item_data.page.id)
	end
	
	
end
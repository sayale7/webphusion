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
		if params[:id]
			@item_data_content = ItemDataContent.find(params[:id])
			@page = @item_data_content.item.page
		else
			@page = Page.find(Item.find(ItemDataContent.find(params[:item_id]).item_id).page_id)
			@theme_item = @page.theme.theme_items.find_by_item_kind('Bilder')
			unless @theme_item.nil?
				@item = Item.find_by_page_id_and_theme_item_id(@page.id, @theme_item.id)
			end
		end
		render :layout => '/layouts/pages'
	end
	
	def update_content
		@item_data_content = ItemDataContent.find(params[:id])
		@item_data_content.update_attributes(params[:item_data_content])
		@page = @item_data_content.item.page
		render :template => '/item_datas/edit_content'
		#redirect_to edit_page_path(@item_data_content.item_data.page.id)
	end
	
	
end
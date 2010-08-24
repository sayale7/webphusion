class ThemeItemsController < ApplicationController
	respond_to :html, :js
	layout 'popup'
	
	def new
		@theme_item = ThemeItem.new
		@theme = Theme.find(params[:id])
		render :template => '/theme_items/form'
	end
	
	def create
		@theme_item = ThemeItem.new(params[:theme_item])
		@theme = Theme.find(@theme_item.theme_id)
		@theme_item.save
		render :template => '/theme_items/ajax'
	end
	
	def edit
		@theme_item = ThemeItem.find(params[:id])
		@theme = Theme.find(@theme_item.theme_id)
		render :template => '/theme_items/form'
	end
	
	def update
		@theme_item = ThemeItem.find(params[:id])
		@theme_item.update_attributes(params[:theme_item])
		@theme = Theme.find(@theme_item.theme_id)
		render :template => '/theme_items/ajax'
	end
	
	def destroy
		theme_item = ThemeItem.find(params[:id])
		@theme = Theme.find(theme_item.theme_id)
		theme_item.destroy
		render :template => '/theme_items/ajax'
	end
	
end
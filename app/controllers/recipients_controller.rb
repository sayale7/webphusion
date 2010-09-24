class RecipientsController < ApplicationController
	
	respond_to :html, :js
	layout '/layouts/application'
	
	def index
		@page = Page.find(params[:page_id])
	end
	
	def new
		@page = Page.find(params[:page_id])
		@recipient = Recipient.new
		render :layout => '/layouts/popup'
	end
	
	def create
		@page = Page.find(params[:page_id])
		@recipient = Recipient.new(params[:recipient])
		@recipient.save
		redirect_to page_recipients_path(@page)
	end
	
	def edit
		@recipient = Recipient.find(params[:id])
		@page = @recipient.page
		render :layout => '/layouts/popup'
	end
	
	def update
		@page = Page.find(params[:page_id])
		@recipient = Recipient.find(params[:id])
		@recipient.update_attributes(params[:recipient])
		redirect_to page_recipients_path(@page)
	end
	
	def destroy
		recipient = Recipient.find(params[:id])
		@page = recipient.page
		recipient.destroy
		redirect_to page_recipients_path(@page)
	end
	
end
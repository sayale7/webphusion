Easywebman::Application.routes.draw do |map|
  
  resources :newsletters

  devise_for :users, :path_names => { :sign_up => "register" }

	resources :assets do
	  collection do
	    put :destroy_selected
	  end
	end
	
	resources :common_files do
	  collection do
	    put :destroy_selected
	  end
	end
	
	resources :theme_uploads do
	  collection do
	    put :destroy_selected
	  end
	end
	
	resources :themes 
	resources :theme_items
	
  match "/users" => "home#index"
  match "/quit_my_account" => "users#quit_account"
	match "/render" => "render#index"
	match "/upload_assets" => "assets#upload_assets"
	match "/upload_common_files" => "common_files#upload_common_files"
	match "/upload_theme_files" =>  "theme_uploads#upload_theme_files"
	match "/upload_files_eiditing" =>  "themes#upload_files_eiditing"
	match "/upload_files_update" =>  "themes#upload_files_update"
	match "/new_content" => "item_datas#new_content"
	match "/item_data_contents" => "item_datas#create_content"
	match "/edit_content" => "item_datas#edit_content"
	match "/update_item_data_contents" => "item_datas#update_content"
	match "/add_item_to_page" =>  "pages#add_item_to_page"
	match "/remove_item_from_page" =>  "pages#remove_item_from_page"
	match "/reorder_pages" => "pages#reorder_pages"
	match "/pages/new" => "pages#new"
	match "/edit_recipient" => "recipients#edit"
	match "/destroy_recipient" => "recipients#destroy"
	match "/deliver_newsletter" => "pages#deliver_newsletter"
	match "/reorder_assets" => "assets#reorder_assets"
	match "/update_asset_order" => "assets#update_asset_order"
	
	constraints(Subdomain) do  
    match '/' => 'pages#show'
  end

  scope "(:locale)", :locale => /en|de/ do
		resources :pages, :only => [:show]
		resources :home
	end
	
	resources :pages, :except => [:show] do
		resources :recipients
	end

  root :to => "home#index"
end

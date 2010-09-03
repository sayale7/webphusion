Easywebman::Application.routes.draw do |map|
  
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
	
	constraints(Subdomain) do  
    match '/' => 'pages#show'    
  end
  
	resources :pages

  root :to => "home#index"
end

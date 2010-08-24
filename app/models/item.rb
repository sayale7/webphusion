class Item < ActiveRecord::Base
	belongs_to :page
	belongs_to :theme_item
	has_many :item_data_contents, :dependent => :destroy
	
	after_save :attach_item_data_contents
	
	def attach_item_data_contents
		self.available_languages.each do |language|
			ItemDataContent.find_or_create_by_locale_and_item_id(language, self.id)
		end
	end
		
	def available_languages
		['de', 'en']
	end
	
end

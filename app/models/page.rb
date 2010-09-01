class Page < ActiveRecord::Base
	
	liquid_methods :id, :name, :title, :parent_id, :sub_pages, :gallery
	
	belongs_to :user
	belongs_to :theme
	has_many :items, :dependent => :destroy
  # has_many :theme_items, :through => :items
	after_save :update_items_for_theme

 	def items_by_theme
		self.items.find_all_by_theme_item_id_and_active(ThemeItem.find_all_by_theme_id(self.theme_id), true)
	end
	
	def self.current_pgae
	  Thread.current[:current_page]
	end
	
  def self.current_page=(page)
    Thread.current[:current_page] = page
  end

	def self.current_locale
	  Thread.current[:current_locale]
	end
	
  def self.current_locale=(locale)
    Thread.current[:current_locale] = locale
  end

	def sub_pages
		Page.find_all_by_parent_id(self.id)
	end
	
	def gallery
		return Asset.find_all_by_collection_id(Item.find_by_page_id_and_theme_item_id(self.id, self.theme.theme_items.find_by_item_kind('Bilder').id).id) rescue nil
	end
	
	def update_items_for_theme
		self.theme.theme_items.each do |theme_item|
			Item.find_or_create_by_theme_item_id_and_page_id(theme_item.id, self.id)
		end
	end
	
end

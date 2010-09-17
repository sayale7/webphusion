class Page < ActiveRecord::Base
	
	liquid_methods :id, :page_url, :name, :title, :parent_id, :sub_pages, :gallery, :added_languages
	
	belongs_to :user
	belongs_to :theme
	has_many :items, :dependent => :destroy
  # has_many :theme_items, :through => :items
	after_save :update_items_for_theme

	def manage_locales(locales)
		Language.all.each do |lang|
			if !locales.nil? and locales.include?(lang.language)
				Localizable.find_or_create_by_localizable_id_and_language_id_and_localizable_type(:localizable_id => self.id, :language_id => lang.id, :localizable_type => "Page")
			else
				if is_added_language(lang.id)
					Localizable.find_by_language_id(lang.id).destroy
				end
			end
		end
	end

	def added_languages
		the_languages = Array.new
		Localizable.find_all_by_localizable_type_and_localizable_id('Page', self.id).each do |lang|
			the_languages.push(Language.find(lang.language_id))
		end
		return the_languages
	end

	def is_added_language(the_id)
		unless Localizable.find_by_localizable_type_and_localizable_id_and_language_id('Page', self.id, the_id).nil?
			true
		else
			false
		end
	end
	
 	def items_by_theme(type)
		self.items.find_all_by_theme_item_id_and_active(ThemeItem.find_all_by_theme_id_and_item_kind(self.theme_id, type.to_s), true)
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
		Page.find_all_by_parent_id(self.id, :order => 'position')
	end
	
	def page_url
		"/#{I18n.locale}/pages/#{self.id}"
	end
	
	def gallery
		item = Item.find_by_page_id_and_theme_item_id(self.id, self.theme.theme_items.find_by_item_kind('Bilder').id)
		return Asset.find_all_by_collection_id(item.id) rescue nil
	end
	
	def update_items_for_theme
		self.theme.theme_items.each do |theme_item|
			Item.find_or_create_by_theme_item_id_and_page_id(theme_item.id, self.id)
		end
	end
	
end

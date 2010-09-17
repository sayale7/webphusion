class PageItem < ActiveRecord::Base
	has_many :linked_page_items
	has_many :pages, :through => :linked_page_items
end

class LinkedPageItem < ActiveRecord::Base
	belongs_to :page_item
	belongs_to :page
end

class Theme < ActiveRecord::Base
	
	belongs_to :user
	has_many :theme_uploads, :dependent => :destroy
	has_many :pages
	has_many :theme_items, :dependent => :destroy
	
	validates_presence_of :name
	validates_uniqueness_of :name
	
	
	# def set_page_themes
	# 		Page.find_all_by_theme_id(self.id).each do |page|
	# 			page.update_attribute(:theme_id, Theme.first.id)
	# 		end
	# 	end
	
	def self.current_theme
	  Thread.current[:current_theme]
	end
	
  def self.current_theme=(them)
    Thread.current[:current_theme] = them
  end
	
	def destroy_if_empty?
		if self.pages.empty?
			return true
		else
			return false
		end
	end
	
end

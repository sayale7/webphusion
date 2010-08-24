class ThemeItem < ActiveRecord::Base
	belongs_to :theme
	has_many :items, :dependent => :destroy
  has_many :pages, :through => :items
end

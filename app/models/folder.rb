class Folder < ActiveRecord::Base
	acts_as_tree :order => "name"
	belongs_to :theme
	has_many :theme_uploads
end

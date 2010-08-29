class ThemeUpload < ActiveRecord::Base
	
	attr_accessible :theme_id, :theme_file
	belongs_to :theme
	#debugger
	has_attached_file :theme_file,
										:url  => "/system/:class/:attachment/:theme_id/:basename.:extension",
										:path => ":rails_root/public/system/:class/:attachment/:theme_id/:basename.:extension"
																										
end

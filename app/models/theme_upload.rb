class ThemeUpload < ActiveRecord::Base
	
	attr_accessible :theme_id, :theme_file
	belongs_to :theme
	
	has_attached_file :theme_file,
										:url  => "/system/:class/:attachment/#{Theme.current_theme}/:basename.:extension",
										:path => ":rails_root/public/system/:class/:attachment/#{Theme.current_theme}/:basename.:extension"
																										
end

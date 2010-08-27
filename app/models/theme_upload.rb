class ThemeUpload < ActiveRecord::Base
	
	attr_accessible :theme_id, :theme_file
	belongs_to :theme
	debugger
	has_attached_file :theme_file,
										:url  => "/system/:class/:attachment/#{Thread.current[:current_theme]}/:basename.:extension",
										:path => ":rails_root/public/system/:class/:attachment/#{Thread.current[:current_theme]}/:basename.:extension"
										# :url  => "/system/:class/:attachment/53/:basename.:extension",
										# :path => ":rails_root/public/system/:class/:attachment/53/:basename.:extension"
																										
end

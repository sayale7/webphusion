class CommonFile < ActiveRecord::Base
	
	attr_accessible :user_id, :asset_file
	belongs_to :user
	has_attached_file :asset_file,
										:url  => "/system/:class/:attachment/:id/:basename.:extension",
										:path => ":rails_root/public/system/:class/:attachment/:id/:basename.:extension"
end

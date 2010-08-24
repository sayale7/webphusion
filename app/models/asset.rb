class Asset < ActiveRecord::Base
	
	liquid_methods :image_path
	
	attr_accessible :user_id, :image, :collection_id
	belongs_to :user
	has_attached_file :image, 
										:styles => { :thumb => ["55x45#", :png],
										             :medium =>  "500x500>" },
										:convert_options => {:thumb => Proc.new{self.convert_options}},
										:url  => "/system/:class/:attachment/:id/:basename.:extension",
										:path => ":rails_root/public/system/:class/:attachment/:id/:basename.:extension"
	
	def self.convert_options
		trans = ""
		px = 5
		trans << " \\( +clone  -threshold -1 "
		trans << "-draw 'fill black polygon 0,0 0,#{px} #{px},0 fill white circle #{px},#{px} #{px},0' "
		trans << "\\( +clone -flip \\) -compose Multiply -composite "
		trans << "\\( +clone -flop \\) -compose Multiply -composite "
		trans << "\\) +matte -compose CopyOpacity -composite "
	end
	
	def image_path
		return self.image.url
	end
end

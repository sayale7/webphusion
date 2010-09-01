class Asset < ActiveRecord::Base
	
	liquid_methods :image_path, :asset_description, :thumb_image_path, :medium_image_path
	
	attr_accessible :user_id, :image, :collection_id, :description
	belongs_to :user
	has_attached_file :image,
	 									:styles => { :medium => "490x490>", :thumb => "65x45#" },
										#:styles => { :thumb => ["65x55#", :png], :medium => "450x450>" },
										#:convert_options => {:thumb => Proc.new{self.convert_options}},
										:url  => "/system/:class/:attachment/:id/:style/:basename.:extension",
										:path => ":rails_root/public/system/:class/:attachment/:id/:style/:basename.:extension"
	
	# def self.convert_options
	# 	trans = ""
	# 	px = 5
	# 	trans << " \\( +clone  -threshold -1 "
	# 	trans << "-draw 'fill black polygon 0,0 0,#{px} #{px},0 fill white circle #{px},#{px} #{px},0' "
	# 	trans << "\\( +clone -flip \\) -compose Multiply -composite "
	# 	trans << "\\( +clone -flop \\) -compose Multiply -composite "
	# 	trans << "\\) +matte -compose CopyOpacity -composite "
	# end,
	
	def image_path
		return self.image.url
	end
	
	def thumb_image_path
		return self.image.url(:thumb)
	end
	
	def medium_image_path
		return self.image.url(:medium)
	end
	
	def asset_description
		return self.description
	end
	
end

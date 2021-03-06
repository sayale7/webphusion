class Asset < ActiveRecord::Base
	
	liquid_methods  :image_path, :asset_description, :thumb_image_path, :medium_image_path, :width, :height, :parent_id, :sub_items
	before_save :set_dimensions


	attr_accessible :user_id, :image, :collection_id, :width, :height, :parent_id, :position
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
	
	after_save :attach_asset_descriptions #, :set_position
	
	def set_position
		self.update_attribute('position', Asset.find_all_by_collection_id_and_parent_id(self.collection_id, self.parent_id).size)
	end
	
	def descriptions
		Description.find_all_by_descriptionable_type_and_descriptionable_id('Asset', self.id)
	end
	
	def attach_asset_descriptions
		self.available_languages.each do |language|
			Description.find_or_create_by_language_and_descriptionable_type_and_descriptionable_id(language, 'Asset', self.id)
		end
	end
		
	def available_languages
		['de', 'en']
	end
	
	def destroy_descriptions
		self.descriptions.each do |description|
			description.destroy
		end
	end
	
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
		return Description.find_by_language_and_descriptionable_type_and_descriptionable_id(I18n.locale, 'Asset', self.id).content
	end
	
	def set_dimensions
	  tempfile = self.image.queued_for_write[:original]

	  unless tempfile.nil?
	    dimensions = Paperclip::Geometry.from_file(tempfile)
	    self.width = dimensions.width
	    self.height = dimensions.height
	  end
	end
	
	def sub_items
		Asset.find_all_by_parent_id_and_collection_id(self.id, self.collection_id)
	end
	
end

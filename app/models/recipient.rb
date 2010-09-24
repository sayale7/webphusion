class Recipient < ActiveRecord::Base
	belongs_to :page
	
	#validates_uniqueness_of :email
	
end

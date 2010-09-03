class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable, :validatable,
         :recoverable, :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :subdomain, :domain

	has_many :assets, :order => 'created_at desc'
	has_many :common_files, :order => 'created_at desc'
	has_many :themes
	has_many :websites
	has_many :pages, :foreign_key => 'website_id'
	
	validates_uniqueness_of :subdomain
	validates_length_of :subdomain, :minimum => 3
	
	
	# def self.current_user_for_model
	#     Thread.current[:current_user]
	#   end
	# 
	#   def self.current_user_for_model=(usr)
	#     Thread.current[:current_user] = usr
	#   end

end

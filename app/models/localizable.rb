class Localizable < ActiveRecord::Base
	belongs_to :localizable, :polymorphic => true
	belongs_to :language
end

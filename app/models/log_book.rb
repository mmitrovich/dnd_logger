class LogBook < ApplicationRecord

	validates :title, 	:presence => :true,
						:uniqueness => true


	has_many :entries, :dependent => :destroy
	has_many :tags, :through => :entries

	scope :sorted, lambda {order('created_at DESC')}
end

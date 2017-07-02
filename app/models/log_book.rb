class LogBook < ApplicationRecord

	validates :title, 	:presence => :true,
						:uniqueness => true


	has_many :entries, :dependent => :destroy

	scope :sorted, lambda {order('created_at DESC')}
end

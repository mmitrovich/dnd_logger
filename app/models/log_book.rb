class LogBook < ApplicationRecord

	validates :title, 	:presence => :true,
						:uniqueness => true

	scope :sorted, lambda {order('created_at DESC')}
end

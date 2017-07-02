class Entry < ApplicationRecord
	validates :description, 	:presence => :true

	belongs_to :log_book

	scope :sorted, lambda {order('created_at DESC')}
end

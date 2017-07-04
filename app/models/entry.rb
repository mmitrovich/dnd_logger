class Entry < ApplicationRecord
	validates :description, 	:presence => :true

	belongs_to :log_book
	has_many :taggings, :dependent => :destroy
	has_many :tags, :through => :taggings, :dependent => :destroy

	scope :sorted, lambda {order('created_at DESC')}
end

class Tag < ApplicationRecord
	has_many :taggings
	has_many :entries, :through => :taggings

	scope :sorted, lambda{order('tag_name ASC')}
end

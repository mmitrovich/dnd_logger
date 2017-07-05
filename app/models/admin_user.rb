class AdminUser < ApplicationRecord
	has_secure_password

	validates :user_name,
		:uniqueness => true
	validates :password,
		:presence => true
end

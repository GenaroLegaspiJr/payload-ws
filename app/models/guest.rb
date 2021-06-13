class Guest < ApplicationRecord
	validates_uniqueness_of :email

	has_many :reservations
end

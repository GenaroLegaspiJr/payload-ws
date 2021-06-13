class Guest < ApplicationRecord
	validates :email, presence: true, uniqueness: true

	has_many :reservations
end

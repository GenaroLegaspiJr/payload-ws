class Reservation < ApplicationRecord
  belongs_to :guest

  enum status: [ :pending, :accepted, :rejected ]
end

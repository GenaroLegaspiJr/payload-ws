require 'rails_helper'

RSpec.describe Reservation, type: :model do
  let(:guest) { FactoryBot.create :guest }

  before do
    @reservation_params = { start_date: Date.today, end_date: Faker::Date.forward(days: 5), nights: Faker::Number.non_zero_digit, 
      guests: Faker::Number.non_zero_digit, adults: Faker::Number.non_zero_digit, children: Faker::Number.non_zero_digit, 
      infants: Faker::Number.non_zero_digit, currency: 'AUD', payout_price: Faker::Number.decimal(l_digits: 4), 
      security_price: Faker::Number.decimal(l_digits: 4), total_price: Faker::Number.decimal(l_digits: 4) }
  end

  context 'validation tests' do
    it 'ensures reservation belogs to guest' do
      reservation = Reservation.create(@reservation_params)
      expect(reservation.errors.full_messages.to_sentence).to eq("Guest must exist")
    end

    it 'it should save successfully' do
      reservation = Reservation.new(@reservation_params.merge(guest: guest)).save
      expect(reservation).to eq(true)
    end
  end
end

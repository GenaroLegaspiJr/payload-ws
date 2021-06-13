require 'rails_helper'

RSpec.describe Guest, type: :model do
  context 'validation tests' do
    it 'ensures email is unique' do
      guest = FactoryBot.create :guest
      new_guest = Guest.create(email: guest.email, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, phone: Faker::PhoneNumber.cell_phone_in_e164)
      expect(new_guest.errors.full_messages.to_sentence).to eq("Email has already been taken")
    end

    it 'it should save successfully' do
      guest = Guest.new(email: Faker::Internet.email, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, phone: Faker::PhoneNumber.cell_phone_in_e164).save
      expect(guest).to eq(true)
    end
  end
end

#rspec spec/controllers/api/v1/reservations_controller_spec.rb

require 'rails_helper'

RSpec.describe  Api::V1::ReservationsController, type: :controller do
  before(:each) {
    @payload1 = {
      start_date: "2021-03-12",
      end_date: "2021-03-16",
      nights: 4,
      guests: 4,
      adults: 2,
      children: 2,
      infants: 0,
      status: "accepted",
      guest: {
        id: 1,
        first_name: "Wayne",
        last_name: "Woodbridge",
        phone: "639123456789",
        email: "wayne_woodbridge@bnb.com"
      },
      currency: "AUD",
      payout_price: "3800.00",
      security_price: "500",
      total_price: "4500.00"
    }

    @payload2 = {
      reservation: {
        start_date: "2021-03-12",
        end_date: "2021-03-16",
        expected_payout_amount: "3800.00",
        guest_details: {
          localized_description: "4 guests",
          number_of_adults: 2,
          number_of_children: 2,
          number_of_infants: 0
        },
        guest_email: "wayne_woodbridge@bnb.com",
        guest_first_name: "Wayne",
        guest_id: 1,
        guest_last_name: "Woodbridge",
        guest_phone_numbers: [
          "639123456789",
          "639123456789"
        ],
        listing_security_price_accurate: "500.00",
        host_currency: "AUD",
        nights: 4,
        number_of_guests: 4,
        status_type: "accepted",
        total_paid_amount_accurate: "4500.00"
      } 
    }
  }

  describe "POST #create" do
    context "with guest email blank" do
      it "returns a status 300 and the guest and reservation will not be created - PAYLOAD 1" do
        payload1 = @payload1
        payload1[:guest].delete(:email)
        post :create, params: payload1

        json = JSON.parse(response.body, symbolize_names: true)
        expect(response.status).to eq 300
        expect(json[:message]).to eq "Guest error: Email can't be blank"
      end

      it "returns a status 300 and the guest and reservation will not be created - PAYLOAD 2" do
        payload2 = @payload2
        payload2[:reservation].delete(:guest_email)
        post :create, params: payload2

        json = JSON.parse(response.body, symbolize_names: true)
        expect(response.status).to eq 300
        expect(json[:message]).to eq "Guest error: Email can't be blank"
      end
    end


    context "reservation successfully created - guest not yet created" do
      it "returns a status 200 and the guest and reservation will not be created - PAYLOAD 1" do
        prev_guest_count = Guest.count
        prev_reservation_count = Reservation.count

        post :create, params: @payload1

        json = JSON.parse(response.body, symbolize_names: true)
        expect(response.status).to eq 200
        expect(json[:message]).to eq "Reservation saved."
        expect(Guest.count).to eq prev_guest_count + 1
        expect(Reservation.count).to eq prev_reservation_count + 1
      end

      it "returns a status 200 and the guest and reservation will be created - PAYLOAD 2" do
        prev_guest_count = Guest.count
        prev_reservation_count = Reservation.count

        post :create, params: @payload2

        json = JSON.parse(response.body, symbolize_names: true)
        expect(response.status).to eq 200
        expect(json[:message]).to eq "Reservation saved."
        expect(Guest.count).to eq prev_guest_count + 1
        expect(Reservation.count).to eq prev_reservation_count + 1
      end
    end

    context "reservation successfully created - guest exist" do
      it "returns a status 200 and only the reservation will be created - PAYLOAD 1" do
        Guest.create @payload1[:guest]

        prev_guest_count = Guest.count
        prev_reservation_count = Reservation.count

        post :create, params: @payload1

        json = JSON.parse(response.body, symbolize_names: true)
        expect(response.status).to eq 200
        expect(json[:message]).to eq "Reservation saved."
        expect(Guest.count).to eq prev_guest_count
        expect(Reservation.count).to eq prev_reservation_count + 1
      end

      it "returns a status 200 and only the reservation will be created - PAYLOAD 2" do
        payload = @payload2[:reservation]
        Guest.create first_name: payload[:guest_first_name], last_name: payload[:guest_last_name], email: payload[:guest_email], phone: payload[:guest_phone_numbers].join(', ')

        prev_guest_count = Guest.count
        prev_reservation_count = Reservation.count

        post :create, params: @payload2

        json = JSON.parse(response.body, symbolize_names: true)
        expect(response.status).to eq 200
        expect(json[:message]).to eq "Reservation saved."
        expect(Guest.count).to eq prev_guest_count
        expect(Reservation.count).to eq prev_reservation_count + 1
      end
    end
  end
end

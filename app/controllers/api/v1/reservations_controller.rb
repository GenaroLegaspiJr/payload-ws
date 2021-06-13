class Api::V1::ReservationsController < ApplicationController
  before_action :get_guest, only: :create

  def create
    reservation = @guest.reservations.build reservation_params

    if reservation.save
      render json: { message: 'Reservation saved.', guest: @guest, reservation: reservation }, status: 200
    else
      render json: { message: "Reservation failed. Error: #{reservation.errors.full_messages.to_sentence}" }, status: 200
    end
  end

  private

  def get_guest
    guest_email = params[:guest] ? params[:guest][:email] : params[:reservation][:guest_email]

    @guest = Guest.find_by_email guest_email

    unless @guest.present?
      create_guest    
    end 
  end

  def create_guest
    @guest = Guest.create guest_params

    if @guest.errors.present?
      return render json: { message: "Guest error: #{@guest.errors.full_messages.to_sentence}" }, status: 300
    end
    # byebug
  end

  def reservation_params
    r_params = params.permit :start_date, :end_date, :nights, :guests, :adults, :children, :infants, :status, :currency, :payout_price, :security_price, :total_price
    r_params = format_reservation_params unless params[:guest]
    return r_params
  end

  def guest_params
    g_params = params.permit :first_name, :last_name, :email, :phone
    g_params = format_guest_params
    return g_params
  end

  def format_reservation_params
    payload = params[:guest] || params[:reservation]
    gd = payload[:guest_details]

    { start_date: payload[:start_date], 
      end_date: payload[:end_date], 
      nights: payload[:nights], 
      guests: payload[:number_of_guests], 
      adults: gd[:number_of_adults],
      children: gd[:number_of_children],
      infants: gd[:number_of_infants],
      status: payload[:status_type], 
      currency: payload[:host_currency], 
      payout_price: payload[:expected_payout_amount], 
      security_price: payload[:listing_security_price_accurate], 
      total_price: payload[:total_paid_amount_accurate] 
    }
  end

  def format_guest_params
    payload = params[:guest] || params[:reservation]

    unless params[:guest]
      { first_name: payload[:guest_first_name], last_name: payload[:guest_last_name], email: payload[:guest_email], phone: payload[:guest_phone_numbers].join(', ')}
    else
      { first_name: payload[:first_name], last_name: payload[:last_name], email: payload[:email], phone: payload[:phone] }
    end
  end
end

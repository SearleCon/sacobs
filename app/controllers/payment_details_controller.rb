class PaymentDetailsController < ApplicationController

  before_action :set_booking

  def new
    @payment_detail = @booking.build_payment_detail
  end

  def create
    @payment_detail = @booking.create_payment_detail(payment_details_params)
    if @payment_detail.valid?
      if @booking.is_return?
        @booking.main.create_payment_detail(payment_details_params)  if @booking.main
      else
        @booking.return.create_payment_detail(payment_details_params) if @booking.return
      end
    end
    respond_with @payment_detail, location: bookings_url
  end

  private
   def set_booking
     @booking = Booking.find(params[:booking_id])
   end

   def payment_details_params
     PaymentDetailParameters.new(params).permit(user: current_user)
   end
end

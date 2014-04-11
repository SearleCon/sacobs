class Ticket

attr_reader :booking, :return ,:client

  def initialize(booking)
    @booking = booking.main ? booking.main.decorate : booking.decorate
    @return = @booking.return_booking if @booking.return_booking
    @client = @booking.client
  end

  def passengers
    @passengers ||= booking.passengers
  end

  def total
    total = 0
    total += @booking.invoice.total
    total += @return.invoice.total if @return
    total
  end

  def total_discount
    total = 0
    total += @booking.invoice.total_discount
    total += @return.invoice.total_discount if @return
    total
  end
end
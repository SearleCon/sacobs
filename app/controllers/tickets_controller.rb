class TicketsController < ApplicationController
  before_action :set_booking

  def download
    @ticket = Ticket.new(@booking, view_context)
    pdf = generate_pdf
    send_data(pdf,
              filename: generate_file_name,
              disposition: :attachment)
  end

  def show
    @ticket = Ticket.new(@booking, view_context)
  end

  def print
    @ticket = Ticket.new(@booking, view_context)
    respond_to do |format|
      format.pdf do
        render pdf: generate_file_name,
               template: 'tickets/_ticket.html.haml',
               disposition: :inline,
               layout: "pdf.html"
      end
    end
  end

  def email
    TicketMailJob.new.async.perform(@booking)
    respond_with @booking, location: ticket_url(@booking), notice: 'Ticket has been emailed successfully'
  end

  private
   def set_booking
     @booking = Booking.find(params[:id])
   end

   def generate_file_name
     "#{@booking.trip_name}_#{@booking.client_name}_#{Time.zone.now.to_i}.pdf".gsub(' ', '_').downcase
   end

   def generate_pdf
     WickedPdf.new.pdf_from_string(render_to_string(template: 'tickets/_ticket.html.haml', layout: "pdf.html"))
   end
end

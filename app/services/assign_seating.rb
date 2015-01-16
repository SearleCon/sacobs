# Updates the seating on the stop by the quantity passed in
class AssignSeating
  include Service

  def initialize(quantity, stop)
    @quantity = quantity
    @stop = stop
    @trip = stop.trip
  end

  def execute
    ActiveRecord::Base.transaction do
      affected_stops.update_all("available_seats = available_seats - #{@quantity}, updated_at = now()")
      @trip.touch
    end
  end

  private

  def affected_stops
    @affected_stops ||= StopsEnRoute.new(@trip, @stop).stops
  end
end

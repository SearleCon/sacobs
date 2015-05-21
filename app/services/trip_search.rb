# Searches for stops based on specific criteria
class TripSearch
  include Service

  def initialize(search_params)
    @search_params = search_params
  end

  def execute
    Stop.includes(:trip, :connection).search(criteria).result.limit(30).order('trips.start_date ASC')
  end

  private

  def criteria
    criteria = {}
    criteria.merge!(available_seats_gt: 0)
    criteria.merge!(trip_start_date_gteq: trip_date) if @search_params.key?(:trip_date)
    criteria.merge!(connection_from_city_id_eq: @search_params[:from_city_id]) if @search_params.key?(:from_city_id)
    criteria.merge!(connection_to_city_id_eq: @search_params[:to_city_id]) if @search_params.key?(:to_city_id)
    criteria
  end

  def trip_date
    @search_params[:trip_date] >= Date.current ? @search_params[:trip_date] : Date.current
  end
end

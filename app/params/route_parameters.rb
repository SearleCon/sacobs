class RouteParameters < Struct.new(:params)
  def permit(additional_attr = {})
    params.fetch(:route, {}).permit(route_attributes, connections_attributes, destinations_attributes).merge(additional_attr)
  end

  private

  def route_attributes
    [:name, :cost, :distance]
  end

  def connections_attributes
    { connections_attributes: [:id, :_destroy, :from_id, :to_id, :distance, :percentage, :cost, :depart, :arrive] }
  end

  def destinations_attributes
    { destinations_attributes: [:city_id, :sequence, :_destroy] }
  end
end

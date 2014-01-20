# == Schema Information
#
# Table name: stops
#
#  id              :integer          not null, primary key
#  connection_id   :integer
#  trip_id         :integer
#  arrive          :datetime
#  depart          :datetime
#  available_seats :integer
#  created_at      :datetime
#  updated_at      :datetime
#
# Indexes
#
#  index_stops_on_connection_id  (connection_id)
#  index_stops_on_trip_id        (trip_id)
#

class Stop < ActiveRecord::Base

 belongs_to :trip
 belongs_to :connection, -> { includes(:from, :to) }
 has_and_belongs_to_many :bookings

 scope :cost, -> { includes(:connection).sum('connections.cost')}
 scope :en_route, -> (destination) { joins(:trip,connection: [:to,:route]).where('destinations.sequence > ?', destination.sequence).readonly(false)}
 scope :valid, -> { joins(:trip).merge(Trip.valid) }

 delegate :name, :from, :to, to: :connection

end


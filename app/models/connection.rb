# == Schema Information
#
# Table name: connections
#
#  id         :integer          not null, primary key
#  distance   :integer          default(0)
#  created_at :datetime
#  updated_at :datetime
#  route_id   :integer
#  percentage :decimal(5, 2)    default(0.0)
#  cost       :decimal(8, 2)    default(0.0)
#  name       :string(255)
#  from_id    :integer
#  to_id      :integer
#  leaving    :time
#  arriving   :time
#
# Indexes
#
#  index_connections_on_from_id   (from_id)
#  index_connections_on_route_id  (route_id)
#  index_connections_on_to_id     (to_id)
#

class Connection < ActiveRecord::Base
  default_scope -> { order(:created_at) }

  belongs_to :route, inverse_of: :connections
  belongs_to :from, -> { includes(:city) }, class_name: :Destination, inverse_of: :connections
  belongs_to :to, -> { includes(:city) }, class_name: :Destination, inverse_of: :connections

  validates :route, :from, :to, :leaving, :arriving, presence: true
  validates :cost, :percentage, presence: true, numericality: true

  before_create :set_name

  delegate :city, to: :from, prefix: true
  delegate :city, to: :to, prefix: true

  protected

  def set_name
    self.name = "#{from_city.name} to #{to_city.name}".squish.upcase
  end
end

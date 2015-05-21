
# == Schema Information
#
# Table name: connections
#
#  id         :integer          not null, primary key
#  distance   :integer
#  created_at :datetime
#  updated_at :datetime
#  route_id   :integer
#  percentage :decimal(5, 2)
#  cost       :decimal(8, 2)
#  name       :string(255)
#  from_id    :integer
#  to_id      :integer
#  arrive     :time
#  depart     :time
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

  validates :route, :from, :to, presence: true
  validates :cost, :percentage, presence: true, numericality: true

  after_initialize :set_defaults, if: :new_record?
  before_save :set_percentage, if: :cost_changed?
  before_create :set_name

  delegate :city_name, :city_venues, to: :from, prefix: true
  delegate :city_name, :city_venues, to: :to, prefix: true

  accepts_nested_attributes_for :from, :to



  protected

  def set_defaults
    self.distance ||= 0
    self.cost ||= 0
    self.percentage ||= 0
    self.arrive ||= Time.current.at_beginning_of_day
    self.depart ||= Time.current.noon
  end

  def set_name
    self.name = "#{from.city.name} to #{to.city.name}"
  end

  def set_percentage
    self.percentage = ((cost / route.cost) * 100).round
  end
end

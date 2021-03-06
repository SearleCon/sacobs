# == Schema Information
#
# Table name: buses
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  capacity   :integer          default(0)
#  year       :string(255)
#  model      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

class Bus < ActiveRecord::Base
  to_param :name

  has_many :seats
  has_many :trips

  accepts_nested_attributes_for :seats, reject_if: :all_blank, allow_destroy: true

  validates :name, :capacity, :year, :model, presence: true
  validates :capacity, numericality: { greater_than: 0 }

  after_create :generate_seats

  def in_use?
    trips.any?
  end

  protected

  def generate_seats
    capacity.times { seats.create! }
  end
end

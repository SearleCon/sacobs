# == Schema Information
#
# Table name: bookings
#
#  id           :integer          not null, primary key
#  trip_id      :integer
#  price        :decimal(, )
#  status       :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  quantity     :integer          default(0)
#  expiry_date  :datetime
#  client_id    :integer
#  user_id      :integer
#  reference_no :string(255)
#

class Booking < ActiveRecord::Base
  include AttributeDefaults

  STATUSES = %w(paid reserved cancelled processing)
  STATUSES.each do |status|
    define_method("#{status}?") { self.status == status }
    scope status, -> { where(status: status ) }
  end

  belongs_to :user
  belongs_to :trip
  belongs_to :client
  has_one :invoice
  has_many :passengers, dependent: :destroy
  has_and_belongs_to_many :stops, autosave: true

  accepts_nested_attributes_for :client, reject_if: :all_blank
  accepts_nested_attributes_for :passengers, reject_if: :all_blank
  accepts_nested_attributes_for :invoice, reject_if: :all_blank

  before_destroy :open_seats

  def reserve
    self.status = 'reserved'
    save
  end

  def mark_as_paid
    self.status = 'paid'
    save
  end

  def cancel
    self.status = 'cancelled'
    save
  end

  def expired?
    self.expiry_date <= Time.zone.now
  end

  private
    def defaults
      { status: 'processing' }
    end

  protected
    def open_seats
      self.stops.each { |s| s.increment!(:available_seats, self.quantity) }
    end
end

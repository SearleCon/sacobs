# == Schema Information
#
# Table name: clients
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  surname    :string(255)
#  created_at :datetime
#  updated_at :datetime
#  tel_no     :string(255)
#  cell_no    :string(255)
#  email      :string(255)
#  slug       :string(255)
#  user_id    :integer
#  full_name  :string(255)
#  high_risk  :boolean          default(FALSE)
#  bank_id    :integer
#
# Indexes
#
#  index_clients_on_bank_id  (bank_id)
#  index_clients_on_slug     (slug) UNIQUE
#  index_clients_on_user_id  (user_id)
#

class Client < ActiveRecord::Base
  extend FriendlyId

  belongs_to :user
  belongs_to :bank
  has_one :address, as: :addressable, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :vouchers, dependent: :destroy

  accepts_nested_attributes_for :address, reject_if: :all_blank, allow_destroy: true

  delegate :street_address1, :street_address2, :city, :postal_code, to: :address, prefix: false, allow_nil: true
  delegate :name, to: :bank, prefix: true, allow_nil: true

  friendly_id :full_name, use: :slugged

  validates :name, presence: true

  after_initialize :init_address, if: :new_record?

  before_validation :set_full_name, prepend: true

  protected
    def init_address
      self.build_address unless self.address.present?
    end

    def set_full_name
      self.full_name = "#{self.name} #{self.surname}"  if name_changed? || surname_changed?
    end

    def should_generate_new_friendly_id?
     full_name_changed?
    end
end

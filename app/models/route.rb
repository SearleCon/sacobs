# == Schema Information
#
# Table name: routes
#
#  id                :integer          not null, primary key
#  cost              :decimal(8, 2)
#  distance          :integer
#  created_at        :datetime
#  updated_at        :datetime
#  name              :string(255)
#  slug              :string(255)
#  user_id           :integer
#  connections_count :integer          default(0)
#
# Indexes
#
#  index_routes_on_slug  (slug) UNIQUE
#

class Route < ActiveRecord::Base
  include AttributesEmpty
  extend FriendlyId

  friendly_id :name, use: :slugged

  belongs_to :user

  has_many :destinations, -> { order(:sequence) }
  has_many :cities, through: :destinations
  has_many :connections, -> { includes(:from, :to) }, dependent: :destroy, autosave: true

  accepts_nested_attributes_for :connections,  reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :destinations, reject_if: :all_blank, allow_destroy: true

  validates :name, :cost, :distance, presence: true, on: :update
end

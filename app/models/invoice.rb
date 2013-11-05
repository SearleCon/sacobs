# == Schema Information
#
# Table name: invoices
#
#  id           :integer          not null, primary key
#  booking_id   :integer
#  created_at   :datetime
#  updated_at   :datetime
#  billing_date :datetime
#

class Invoice < ActiveRecord::Base
  include AttributeDefaults

  belongs_to :booking, touch: true
  has_many :line_items, dependent: :destroy

  attr_reader :total

  def total
    @total ||= self.line_items.sum(:amount).round(2)
  end




  private
  def defaults
    { billing_date: Time.zone.now }
  end

end

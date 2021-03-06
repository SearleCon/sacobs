# == Schema Information
#
# Table name: settings
#
#  id                    :integer          not null, primary key
#  booking_expiry_period :integer
#  created_at            :datetime
#  updated_at            :datetime
#  ticket_instructions   :string(255)
#  default_scripture     :string(255)
#  trip_sheet_note1      :string(255)
#  trip_sheet_note2      :string(255)
#  trip_sheet_note3      :string(255)
#  trip_sheet_note4      :string(255)
#  email                 :string
#

class Setting < ActiveRecord::Base
  after_save :clear_cache

  private

  def clear_cache
    Rails.cache.delete(:common_app_settings)
  end
end

# == Schema Information
#
# Table name: discounts
#
#  id                :integer          not null, primary key
#  percentage        :decimal(2, 5)
#  passenger_type_id :integer
#  created_at        :datetime
#  updated_at        :datetime
#  user_id           :integer
#

require 'spec_helper'

describe Discount do
  pending "add some examples to (or delete) #{__FILE__}"
end

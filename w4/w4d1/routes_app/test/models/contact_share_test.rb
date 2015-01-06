# == Schema Information
#
# Table name: contact_shares
#
#  id                  :integer          not null, primary key
#  user_id             :integer          not null
#  contact_id          :integer          not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  fav_shared_contacts :boolean
#

require 'test_helper'

class ContactShareTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

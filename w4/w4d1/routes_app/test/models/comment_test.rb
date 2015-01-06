# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  title            :string           not null
#  body             :text             not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  commentable_id   :integer
#  commentable_type :string
#

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

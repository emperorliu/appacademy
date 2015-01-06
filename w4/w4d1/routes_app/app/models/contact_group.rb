# == Schema Information
#
# Table name: contact_groups
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  user_id    :integer          not null
#  contact_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ContactGroup < ActiveRecord::Base
  belongs_to :user
  belongs_to :contact
end

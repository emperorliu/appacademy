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

class ContactShare < ActiveRecord::Base
  validates :user_id, presence: true, uniqueness: true
  validates :contact_id, presence: true, uniqueness: true

  belongs_to :contact
  belongs_to :user

end

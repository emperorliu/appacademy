# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  username   :string           not null
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true

  has_many :contact_shares
  has_many :shared_contacts, through: :contact_shares, source: :contact
  has_many :contacts

  has_many :comments, as: :commentable
  has_many :contact_groups
end

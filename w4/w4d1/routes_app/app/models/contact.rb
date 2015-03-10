# == Schema Information
#
# Table name: contacts
#
#  id           :integer          not null, primary key
#  name         :string           not null
#  email        :string           not null
#  user_id      :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  fav_contacts :boolean
#

class Contact < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  belongs_to :user
  has_many :contact_shares, dependent: :destroy
  has_many :shared_users, through: :contact_shares, source: :user

  has_many :comments, as: :commentable
  has_many :contact_groups
end

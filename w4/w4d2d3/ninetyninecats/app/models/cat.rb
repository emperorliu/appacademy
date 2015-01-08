# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string           not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#

class Cat < ActiveRecord::Base
  validates :name, :color, :birth_date, :sex, :user_id, presence: true

  has_many :cat_rental_requests, :dependent => :destroy
  belongs_to :owner,
    class_name:   :User,
    foreign_key:  :user_id,
    primary_key:  :id

  COLORS = ['green', 'hot pink', 'blue', 'black', 'brown', 'red']

  def age
    self.birth_date
  end

end

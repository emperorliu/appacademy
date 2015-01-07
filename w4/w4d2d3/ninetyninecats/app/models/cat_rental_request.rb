# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CatRentalRequest < ActiveRecord::Base
  validates :cat_id,      presence: true
  validates :start_date,  presence: true
  validates :end_date,    presence: true
  validates :status,      presence: true

  validate  :overlapping_approved_requests

  after_initialize :set_initial_status

  belongs_to :cat

  def overlapping_approved_requests
    approved_rentals = self.class.all.where(status: "APPROVED")
    approved_rentals.each do |rental|
      if (start_date <= rental.start_date && start_date >= rental.end_date) ||
         (end_date <= rental.start_date && end_date >= rental.end_date)

        false
      end
    end

    true
  end

  def set_initial_status
    self.status ||= "PENDING"
  end

  def approve!
    overlapping_approved_requests ? self.status = "APPROVED" : deny!
  end

  def deny!
    self.status = "REJECTED"
  end

  def pending?
    self.status == "PENDING"
  end
end

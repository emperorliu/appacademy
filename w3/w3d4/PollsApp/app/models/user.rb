# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  user_name  :string           not null
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base

  validates :user_name, presence: true, uniqueness: true

  has_many(
    :authored_polls,
    class_name: "Poll",
    foreign_key: :author_id,
    primary_key: :id
  )

  has_many(
    :responses,
    class_name: "Response",
    foreign_key: :responder_id,
    primary_key: :id
  )

  has_many(
    :answer_choices,
    through: :responses,
    source: :answer_choice
  )

  def completed_polls
    poll_count = {}

    arr = Poll.all
      .joins('LEFT OUTER JOIN questions q ON q.poll_id = polls.id')
      .joins(:answer_choices => :responses)
      .where('responses.responder_id = ? OR responses.id is null', self.id)
      .group('polls.id')
      .select('polls.title, COUNT(distinct q.id) as q')
      .having('COUNT(distinct responses.id) = COUNT(distinct q.id)')

    arr.each do |poll|
      poll_count[poll.title] = poll.q
    end

    poll_count
  end
end

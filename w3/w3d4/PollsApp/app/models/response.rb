# == Schema Information
#
# Table name: responses
#
#  id           :integer          not null, primary key
#  answer_id    :integer
#  responder_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Response < ActiveRecord::Base

  validates :answer_id, presence: true
  validates :responder_id, presence: true
  validate :respondent_has_not_already_answered_question
  validate :respondent_cannot_respond_to_own_poll

  belongs_to(
    :respondent,
    class_name: "User",
    foreign_key: :responder_id,
    primary_key: :id
  )

  belongs_to(
    :answer_choice,
    class_name: "AnswerChoice",
    foreign_key: :answer_id,
    primary_key: :id
  )

  has_one(
    :question,
    through: :answer_choice,
    source: :question
  )

  def sibling_responses
    question.responses.where('responses.id <> :id OR :id IS NULL', id: self.id)
  end

  private
  def respondent_has_not_already_answered_question
    if sibling_responses.exists?(responder_id: responder_id)
      errors[:question] << "has already been answered"
    end
  end

  def respondent_cannot_respond_to_own_poll
    if responder_id == answer_choice.question.poll.author_id
      errors[:base] << "User cannot respond to own poll"
    end
  end
end

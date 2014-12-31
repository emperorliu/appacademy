# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  text       :text             not null
#  poll_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Question < ActiveRecord::Base

  validates :text, presence: true
  validates :poll_id, presence: true

  belongs_to(
    :poll,
    class_name: "Poll",
    foreign_key: :poll_id,
    primary_key: :id
  )

  has_many(
    :answer_choices,
    class_name: "AnswerChoice",
    foreign_key: :question_id,
    primary_key: :id
  )

  has_many(
    :responses,
    through: :answer_choices,
    source: :responses
  )

  def results
    choice_count = {}

    arr = answer_choices
      .joins('LEFT OUTER JOIN responses r ON r.answer_id = answer_choices.id')
      .group('answer_choices.id')
      .select('answer_choices.text, COUNT(*) as c')

    arr.each do |choice|
      choice_count[choice.text] = choice.c
    end

    choice_count
  end
end

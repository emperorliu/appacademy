# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ActiveRecord::Base.transaction do
  u1 = User.create!(user_name: "User1")
  u2 = User.create!(user_name: "User2")
  u3 = User.create!(user_name: "User3")

  p1 = u1.authored_polls.create!(title: "Poll1")

  q1 = p1.questions.create!(text: "Fav Color")
  q2 = p1.questions.create!(text: "Fav Food")

  ac1 = q1.answer_choices.create!(text: "Blue")
  ac2 = q1.answer_choices.create!(text: "Red")
  ac3 = q2.answer_choices.create!(text: "Ice Cream")
  ac4 = q2.answer_choices.create!(text: "Pizza")

  r1 = ac2.responses.create!(responder_id: u2.id)
  r2 = ac3.responses.create!(responder_id: u2.id)
  r3 = ac2.responses.create!(responder_id: u3.id)
end

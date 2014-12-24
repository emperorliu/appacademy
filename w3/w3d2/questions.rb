require 'singleton'
require 'sqlite3'
require 'active_support/inflector'


class Base

  def table_name
    ActiveSupport::Inflector.pluralize(self.class.to_s.downcase)
  end

  def column_names
    data = QuestionsDatabase.instance.execute(<<-SQL)
      PRAGMA table_info('#{table_name}')
    SQL

    arr = []
    data.each { |hash| hash.each { |k, v| arr << v if k == "name" } }
    arr[1..-1].join(", ")
  end

  def column_to_qmarks
    arr = column_names.split(", ").zip(Array.new(instance_variables.length, '?'))
    arr.map { |i| i[0].to_s + "=" + i[1].to_s }.join(", ")
  end

  def save
    if id.nil?
      QuestionsDatabase.instance.execute(<<-SQL, *instance_variables)
        INSERT INTO
          #{table_name} (#{column_names})
        VALUES
          (#{Array.new(instance_variables.length, '?').join(", ") })
      SQL

      @id = QuestionsDatabase.instance.last_insert_row_id
    else
      QuestionsDatabase.instance.execute(<<-SQL, *instance_variables, self.id)
        UPDATE
          #{table_name}
        SET
          #{column_to_qmarks}
        WHERE
          id = ?
      SQL
    end
  end
end


class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.results_as_hash = true
    self.type_translation = true
  end

end


class Question < Base

  attr_accessor :title, :body, :user_id
  attr_reader :id

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @user_id = options['user_id']
  end

  def instance_variables
    [self.title, self.body, self.user_id]
  end

  def self.find_by_id(id)
    q_data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        questions.id = ?
    SQL

    q_data.map { |data| Question.new(data) }.first
  end

  def self.find_by_author_id(author_id)
    q_data = QuestionsDatabase.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        questions.user_id = ?
    SQL

    q_data.map { |data| Question.new(data) }.first
  end

  def author
    q_data = QuestionsDatabase.instance.execute(<<-SQL, self.user_id)
      SELECT
        *
      FROM
        users
      WHERE
        users.id = ?
    SQL

    q_data.map { |data| User.new(data) }.first
  end

  def replies
    Reply.find_by_question_id(self.id)
  end

  def followers
    QuestionFollowers.followers_for_question_id(self.id)
  end

  def self.most_followed(n)
    QuestionFollower.most_followed_questions(n)
  end

  def likers
    QuestionLike.likers_for_question_id(self.id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(self.id)
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end
end

class User < Base

  attr_accessor :fname, :lname
  attr_reader :id

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def instance_variables
    [self.fname, self.lname]
  end

  def self.find_by_id(id)
    u_data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        users.id = ?
    SQL

    u_data.map { |data| User.new(data) }.first
  end

  def self.find_by_name(fname, lname)
    u_data = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        users.fname = ? AND users.lname = ?
    SQL

    u_data.map { |data| User.new(data) }.first
  end

  def authored_questions
    Question.find_by_author_id(self.id)
  end

  def authored_replies
    Reply.find_by_user_id(self.id)
  end

  def followed_questions
    QuestionFollower.followed_questions_for_user_id(self.id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(self.id)
  end

  def average_karma
    u_data = QuestionsDatabase.instance.execute(<<-SQL, self.id)
    SELECT
      CAST(COUNT(question_likes.id) AS FLOAT) / COUNT(DISTINCT(questions.id))
    FROM
      questions
    LEFT OUTER JOIN
      question_likes ON question_likes.questions_id = questions.id
    WHERE
      questions.user_id = ?
    SQL
    u_data.first.values.first
  end
end


class QuestionFollower < Base

  attr_accessor :user_id, :questions_id
  attr_reader :id

  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @questions_id = options['questions_id']
  end

  def self.find_by_id(id)
    u_data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_followers
      WHERE
        question_followers.id = ?
    SQL

    u_data.map { |data| QuestionFollower.new(data) }.first
  end

  def self.followers_for_question_id(question_id)
    u_data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.id,  users.fname, users.lname
      FROM
        users
      JOIN
        question_followers ON user_id = users.id
      WHERE
        question_followers.questions_id = ?
    SQL

    u_data.map { |data| User.new(data) }
  end

  def self.followed_questions_for_user_id(user_id)
    u_data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.title, questions.body, questions.user_id
      FROM
        questions
      JOIN
        question_followers ON questions.id = questions_id
      WHERE
        question_followers.user_id = ?
    SQL

      u_data.map { |data| Question.new(data) }
  end

  def self.most_followed_questions(n)
    u_data = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        questions.title, questions.body, questions.user_id
      FROM
        questions
      JOIN
        question_followers ON questions.id = questions_id
      GROUP BY
        questions.title
      ORDER BY
        COUNT(question_followers.id) DESC
    SQL

    u_data.map { |data| Question.new(data) }.take(n)
  end
end


class Reply < Base

  attr_accessor :reply, :questions_id, :parent_reply_id, :replier_id
  attr_reader :id

  def initialize(options)
    @id = options['id']
    @reply = options['reply']
    @questions_id = options['questions_id']
    @parent_reply_id = options['parent_reply_id']
    @replier_id = options['replier_id']
  end

  def instance_variables
    [self.reply, self.questions_id, self.parent_reply_id, self.replier_id]
  end

  def self.find_by_id(id)
    u_data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        replies.id = ?
    SQL

    u_data.map { |data| Reply.new(data) }.first
  end

  def find_by_question_id(question_id)
    u_data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        questions
      WHERE
      questions.id = ?
    SQL

    u_data.map { |data| Reply.new(data) }
  end

  def find_by_user_id(user_id)
    u_data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        users
      WHERE
        users.id = ?
    SQL

    u_data.map { |data| Reply.new(data) }
  end

  def author
    u_data = QuestionsDatabase.instance.execute(<<-SQL, self.replier_id)
      SELECT
        *
      FROM
        users
      WHERE
        users.id = ?
    SQL

    u_data.map { |data| User.new(data) }.first
  end

  def question
    u_data = QuestionsDatabase.instance.execute(<<-SQL, self.questions_id)
      SELECT
        *
      FROM
        questions
      WHERE
        questions.id = ?
    SQL

    u_data.map { |data| Question.new(data) }.first
  end

  def parent_reply
    u_data = QuestionsDatabase.instance.execute(<<-SQL, self.parent_reply_id)
      SELECT
        *
      FROM
        replies
      WHERE
        replies.id = ?
    SQL

    u_data.map { |data| Reply.new(data) }.first
  end

  def child_replies
    u_data = QuestionsDatabase.instance.execute(<<-SQL, self.id)
      SELECT
        *
      FROM
        replies
      WHERE
        replies.parent_reply_id = ?
    SQL

    u_data.map { |data| Reply.new(data) }.first

  end

end


class QuestionLike < Base

  attr_accessor :user_id, :questions_id
  attr_reader :id

  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @questions_id = options['questions_id']
  end

  def self.find_by_id(id)
    u_data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_likes
      WHERE
        question_likes.id = ?
    SQL

    u_data.map { |data| QuestionLike.new(data) }.first
  end

  def self.likers_for_question_id(question_id)
    u_data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      users.fname, users.lname
    FROM
      question_likes
    JOIN
      users ON question_likes.user_id = users.id
    WHERE
      question_likes.questions_id = ?
    SQL

    u_data.map { |data| User.new(data) }
  end

  def self.num_likes_for_question_id(question_id)
    u_data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        COUNT(id)
      FROM
        question_likes
      WHERE
        question_likes.questions_id = ?
    SQL

    u_data.first.values.first
  end

  def self.liked_questions_for_user_id(user_id)
    u_data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        title, body, questions.user_id
      FROM
        question_likes
      JOIN
        questions ON question_likes.questions_id = questions.id
      WHERE
        question_likes.user_id = ?
    SQL

    u_data.map { |data| Question.new(data) }
  end

  def self.most_liked_questions(n)
    u_data = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        questions.title, questions.body, questions.user_id
      FROM
        questions
      JOIN
        question_likes ON questions.id = questions_id
      GROUP BY
        questions.title
      ORDER BY
        COUNT(question_likes.id) DESC
    SQL

    u_data.map { |data| Question.new(data) }.take(n)
  end

end

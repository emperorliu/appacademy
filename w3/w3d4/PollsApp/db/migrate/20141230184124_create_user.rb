class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name, null: false

      t.timestamps
    end

    create_table :polls do |t|
      t.string :title, null: false
      t.integer :author_id

      t.timestamps
    end

    create_table :questions do |t|
      t.text :text, null: false
      t.integer :poll_id

      t.timestamps
    end

    create_table :answer_choices do |t|
      t.text :text, null: false
      t.integer :question_id

      t.timestamps
    end

    create_table :responses do |t|
      t.integer :answer_id
      t.integer :responder_id

      t.timestamps
    end

    add_index :polls, :author_id
    add_index :questions, :poll_id
    add_index :answer_choices, :question_id
    add_index :responses, [:answer_id, :responder_id]
  end
end

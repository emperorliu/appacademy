class CreateChangeIndex < ActiveRecord::Migration
  def change
    remove_index :responses, [:answer_id, :responder_id]
    add_index :responses, [:answer_id, :responder_id], unique: true
  end
end

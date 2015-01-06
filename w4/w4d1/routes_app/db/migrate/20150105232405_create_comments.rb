class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string  :title, null: false
      t.text    :body, null: false
      t.integer :user_id
      t.integer :contact_id

      t.timestamps null: false
    end
  end
end

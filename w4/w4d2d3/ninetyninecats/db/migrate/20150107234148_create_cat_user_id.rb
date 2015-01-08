class CreateCatUserId < ActiveRecord::Migration
  def change
    add_column :cats, :user_id, :integer
    
    Cat.all.each do |cat|
      cat.user_id = 1
      cat.save!
    end

    change_column :cats, :user_id, :integer, null: false
    add_index :cats, :user_id
  end
end

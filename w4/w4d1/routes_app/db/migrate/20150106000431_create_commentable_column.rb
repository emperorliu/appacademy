class CreateCommentableColumn < ActiveRecord::Migration
  def change
    remove_column :comments, :user_id
    remove_column :comments, :contact_id
    add_column    :comments, :commentable_id,   :integer
    add_column    :comments, :commentable_type, :string
  end
end

class CreateTagTopic < ActiveRecord::Migration
  def change
    create_table :tag_topics do |t|
      t.string :tag

      t.timestamps
    end
    
    create_table :taggings do |t|
      t.integer :tag_id
      t.integer :shortened_url_id

      t.timestamps
    end

  end
end

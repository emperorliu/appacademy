class CreateFavoriteContact < ActiveRecord::Migration
  def change
    add_column :contacts, :fav_contacts,        :boolean
    add_column :contact_shares, :fav_shared_contacts, :boolean
  end
end

class AddUidToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :uid, :string
    add_column :users, :image, :string
    remove_column :users, :password_digest, :string
  end
end

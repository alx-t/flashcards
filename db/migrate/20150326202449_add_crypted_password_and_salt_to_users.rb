class AddCryptedPasswordAndSaltToUsers < ActiveRecord::Migration
  def change
    add_column :users, :crypted_password, :string
    add_column :users, :salt, :string

    add_index :users, :email
  end
end

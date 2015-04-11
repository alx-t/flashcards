class AddForeignKeyToUsers < ActiveRecord::Migration
  def change
    add_foreign_key :users, :packs, column: :current_pack_id
  end
end

class AddCurrentPackReferenceToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :current_pack, index: true, references: :packs
    #add_foreign_key :users, :packs, column: :current_pack
  end
end

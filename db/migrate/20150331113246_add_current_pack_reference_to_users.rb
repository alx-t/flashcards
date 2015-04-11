class AddCurrentPackReferenceToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :current_pack, index: true, references: :packs
  end
end

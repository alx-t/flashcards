class AddPackReferencesToCards < ActiveRecord::Migration
  def change
    add_reference :cards, :pack, index: true
    add_foreign_key :cards, :packs
  end
end

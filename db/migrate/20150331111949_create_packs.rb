class CreatePacks < ActiveRecord::Migration
  def change
    create_table :packs do |t|
      t.string :title
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :packs, :users
  end
end

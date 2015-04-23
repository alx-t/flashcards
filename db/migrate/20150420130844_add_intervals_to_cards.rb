class AddIntervalsToCards < ActiveRecord::Migration
  def change
    add_column :cards, :interval, :integer, default: 0
    add_column :cards, :efactor, :decimal, default: 2.5
  end
end

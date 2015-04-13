class AddAttemptsToCards < ActiveRecord::Migration
  def change
    add_column :cards, :attempts, :integer, default: 0
    add_column :cards, :repetition_number, :integer, default: 0
  end
end

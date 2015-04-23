class RemoveAttemptsFromCards < ActiveRecord::Migration
  def change
    remove_column :cards, :attempts
    remove_column :cards, :repetition_number
  end
end

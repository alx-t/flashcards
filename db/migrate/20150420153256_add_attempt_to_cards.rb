class AddAttemptToCards < ActiveRecord::Migration
  def change
    add_column :cards, :attempts, :integer, default: 0
  end
end

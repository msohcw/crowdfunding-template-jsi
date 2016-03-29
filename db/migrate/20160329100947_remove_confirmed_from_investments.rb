class RemoveConfirmedFromInvestments < ActiveRecord::Migration
  def change
    remove_column :investments, :confirmed, :boolean
  end
end

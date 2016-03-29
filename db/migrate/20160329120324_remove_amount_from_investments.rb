class RemoveAmountFromInvestments < ActiveRecord::Migration
  def change
    remove_column :investments, :amount, :integer
  end
end

class AddIntendedAndConfirmedAmountsToInvestments < ActiveRecord::Migration
  def change
    add_column :investments, :intended_amount, :integer
    add_column :investments, :confirmed_amount, :integer
  end
end

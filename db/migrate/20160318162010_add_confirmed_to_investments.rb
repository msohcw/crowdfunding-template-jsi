class AddConfirmedToInvestments < ActiveRecord::Migration
  def change
    add_column :investments, :confirmed, :boolean
  end
end

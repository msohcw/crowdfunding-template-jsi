class AddStripeCardRefToInvestments < ActiveRecord::Migration
  def change
    add_column :investments, :stripe_card_ref, :string
  end
end

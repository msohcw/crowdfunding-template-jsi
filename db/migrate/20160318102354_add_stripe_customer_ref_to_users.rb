class AddStripeCustomerRefToUsers < ActiveRecord::Migration
  def change
    add_column :users, :stripe_customer_ref, :string
  end
end

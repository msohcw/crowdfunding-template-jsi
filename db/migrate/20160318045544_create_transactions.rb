class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :amount
      t.references :user, index: true, foreign_key: true
      t.references :project, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

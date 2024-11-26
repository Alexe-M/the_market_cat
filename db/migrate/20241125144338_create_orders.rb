class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.float :total_price
      t.string :status
      t.integer :stripe_customer_id

      t.timestamps
    end
  end
end
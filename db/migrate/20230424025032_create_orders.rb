class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      
       t.integer :customer_id
       t.string :post_code
       t.string :shipping_address
       t.string :shipping_name
       t.integer :postage
       t.integer :total_payment
       t.integer :payment_method, default: 0
       t.integer :status, default: 0

      t.timestamps
    end
  end
end

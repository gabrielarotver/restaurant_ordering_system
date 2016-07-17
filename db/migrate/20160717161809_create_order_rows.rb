class CreateOrderRows < ActiveRecord::Migration[5.0]
  def change
    create_table :order_rows do |t|
      t.references :item, foreign_key: true
      t.references :order, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end

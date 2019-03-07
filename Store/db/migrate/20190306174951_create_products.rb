class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :sku
      t.string :product_name
      t.float :price
      t.integer :quantity
      t.references :category, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end

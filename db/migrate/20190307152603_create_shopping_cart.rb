class CreateShoppingCart < ActiveRecord::Migration[5.2]
  def change
    create_table :shopping_carts do |t|
      t.references :user
      t.references :product, foreign_key: true
      t.integer :quantity
      t.decimal :price
      t.string :status

      t.timestamps
    end
  end
end

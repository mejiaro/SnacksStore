class CreateCarShops < ActiveRecord::Migration[5.2]
  def change
    create_table :car_shops do |t|
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :quantity
      t.float :price
      t.string :status

      t.timestamps
    end
  end
end

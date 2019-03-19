class CreateLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :logs do |t|
      t.references :user, foreign_key: true
      t.text :description
      t.references :product, foreign_key: true
      t.decimal :old_price
      t.decimal :new_price

      t.timestamps
    end
  end
end

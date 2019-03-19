class CreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :roles do |t|
      t.string :rol_name

      t.timestamps
    end
  end
end

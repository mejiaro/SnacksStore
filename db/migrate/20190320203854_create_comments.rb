class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :review
      t.belongs_to :commentable, polymorphic: true
      t.references :user, foreign_key: true
      t.string :status

      t.timestamps
    end
    add_index :comments, %i[commentable_id commentable_type]
  end
end

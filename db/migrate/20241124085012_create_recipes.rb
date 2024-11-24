class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :method
      t.integer :temp
      t.float :ratio

      t.timestamps
    end
  end
end

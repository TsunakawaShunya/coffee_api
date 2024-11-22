class CreateBeans < ActiveRecord::Migration[7.1]
  def change
    create_table :beans do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :roast
      t.string :process

      t.timestamps
    end
  end
end

class CreateNotes < ActiveRecord::Migration[7.1]
  def change
    create_table :notes do |t|
      t.references :bean, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true
      t.float :taste_x, null: false, default: 0  # 横軸（酸味から苦味）
      t.float :taste_y, null: false, default: 0  # 縦軸（濃度）
      t.text :comment

      t.timestamps
    end
  end
end
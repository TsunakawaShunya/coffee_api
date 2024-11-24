class Note < ApplicationRecord
  belongs_to :bean
  belongs_to :recipe

  # 酸味から苦味、濃度のスケール（-5.0〜5.0）で制限
  validates :taste_x, numericality: { greater_than_or_equal_to: -5.0, less_than_or_equal_to: 5.0 }
  validates :taste_y, numericality: { greater_than_or_equal_to: -5.0, less_than_or_equal_to: 5.0 }

  # コメントの最大文字数制限
  validates :comment, length: { maximum: 500 }
end

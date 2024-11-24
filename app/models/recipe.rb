class Recipe < ApplicationRecord
  belongs_to :user
  has_many :notes, dependent: :destroy

  validates :title, :method, presence: true
end
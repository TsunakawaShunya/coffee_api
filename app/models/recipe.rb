class Recipe < ApplicationRecord
  belongs_to :user
  has_many :notes, dependent: :destroy

  validates :method, presence: true
end
class Recipe < ApplicationRecord
  belongs_to :user

  validates :title, :method, presence: true
end

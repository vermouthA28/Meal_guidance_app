class Post < ApplicationRecord

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :todos, dependent: :destroy
  has_one_attached :image
  
  validates :eaten_at, presence: true
  validates :meal_content, presence: true
  validates :genre_id, presence: true

  enum genre_id: { breakfast: 0, lunch: 1, dinner: 2, snack: 3 }
end

class Post < ApplicationRecord

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :image

  enum genre_:{ breakfast: 0, lunch: 1, dinner: 2, snack: 3 }
end

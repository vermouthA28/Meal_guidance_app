class Post < ApplicationRecord
  belongs_to :genre
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :image
end

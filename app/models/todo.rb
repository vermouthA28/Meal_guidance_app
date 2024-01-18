class Todo < ApplicationRecord
  belongs_to :user
  belongs_to :admin
  has_many :post_todos, dependent: :destroy
  has_many :posts, through: :post_todos
  
  validates :todo, presence: true
end

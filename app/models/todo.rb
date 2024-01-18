class Todo < ApplicationRecord
  belongs_to :user
  belongs_to :admin
  belongs_to :post
  
  validates :todo, presence: true
end

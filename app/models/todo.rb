class Todo < ApplicationRecord
  belongs_to :user
  belongs_to :admin
  
  validates :todo, presence: true
end

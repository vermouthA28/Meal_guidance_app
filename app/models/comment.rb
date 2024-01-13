class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :admin
  belongs_to :user
  
end

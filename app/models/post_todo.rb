class PostTodo < ApplicationRecord
  belongs_to :post
  belongs_to :todo
end

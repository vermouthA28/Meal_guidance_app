class Todo < ApplicationRecord
  belongs_to :my_user
  belongs_to :dietician
end

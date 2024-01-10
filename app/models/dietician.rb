class Dietician < ApplicationRecord
  devise :database_authenticatable
  
  has_many :coaches
  has_many :users, through: :coaches

end

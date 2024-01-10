class MyUser < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :todos, dependent: :destroy
  
  has_many :coaches
  has_many :dieticians,through: :coaches
  
  def only_active
    where(is_active: true)
  end
end

class Chat < ApplicationRecord

  belongs_to :admin,optional: true
  belongs_to :user,optional: true
  belongs_to :room
  has_one :notification, as: :notifiable, dependent: :destroy 

  validates :message, presence: true, length: { maximum: 140 }
end

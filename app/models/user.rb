class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :admin
  has_many :posts, dependent: :destroy
  has_many :todos, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }
  validates :last_name, presence: true
  validates :first_name, presence: true


  def active_for_authentication?
    super && is_active?
  end



GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
      user.last_name = "ゲスト"
      user.first_name = "ユーザー"
      user.admin_id = params[:admin_id]
    end
  end

  def guest_user?
    email == GUEST_USER_EMAIL
  end


  def full_name
    if guest_user?
      "ゲストユーザー"
    else
      [last_name, first_name].join(" ")
    end
  end


end

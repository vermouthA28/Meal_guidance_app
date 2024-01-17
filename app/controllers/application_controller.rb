class ApplicationController < ActionController::Base
add_flash_types :success, :info, :warning, :danger

private

  def reset_guest_data
     guest_user = User.find_by(email: User::GUEST_USER_EMAIL)
     guest_user.posts.destroy_all if guest_user.posts.any?
  end
end


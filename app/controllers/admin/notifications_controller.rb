class Admin::NotificationsController < ApplicationController
   #before_action :authenticate_admin!

   def update
    notification = current_admin.notifications.find(params[:id])
    notification.update(read: true)
    redirect_to notification.notifiable_path
  end
end

class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  
  def edit
  end
end

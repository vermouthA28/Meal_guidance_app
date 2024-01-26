class Admin::ExclusivesController < ApplicationController
  before_action :authenticate_admin!
  
end

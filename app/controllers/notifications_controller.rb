class NotificationsController < ApplicationController
  def index
    
  end
  
  def notifications
    user_notifications
    render :layout => false
  end
end
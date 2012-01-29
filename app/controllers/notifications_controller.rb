class NotificationsController < ApplicationController
  def index
    
  end
  
  def notifications
    user_notifications
    respond_to do |format|
      partial = render_to_string "notifications/notifications.html.haml"
      format.json {render :json => partial}
      format.html {render :layout => false}
    end
  end
end
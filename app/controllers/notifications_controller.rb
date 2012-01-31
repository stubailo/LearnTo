class NotificationsController < ApplicationController
  def index
    user_notifications
    respond_to do |format|
      format.json do
        @notifications = @notifications.first(10)
        partial = render_to_string "notifications/notifications.html.haml"
        render :json => {:notifications_html => partial}
      end
      format.html
    end
  end
  
  def count
    respond_to do |format|
      format.json do
        count = user_notifications_number
        render :json => {:count => count}
      end
    end
  end
  
end

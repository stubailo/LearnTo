class NotificationsController < ApplicationController
  def index
    user_notifications
    respond_to do |format|
      format.json do
        partial = render_to_string "notifications/notifications.html.haml"
        render :json => {:notifications_html => partial}
      end
      format.html do
        render :layout => false
      end
    end
  end
end

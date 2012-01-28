class AnnouncementsController < ApplicationController
  def show
    @class_room = ClassRoom.find(params[:class_room_id])
    set_vars
    @announcements = @class_room.announcements
    render :layout => "layouts/show_class_room", :locals => {:which_tab => "home"}
  end
  
  def create
    @na = Announcement.new(params[:announcement])
    @na.user_id = current_user.id
    @na.class_room_id = params[:class_room_id]
    @na.save
    class_notification("new_announcement","Announcement",@na.class_room,@na.id)
    redirect_to :back
  end

  def destroy
    @announcement = Announcement.find(params[:announcement_id])
    if @announcement.user_id != current_user.id
      redirect_to root_url
    end
    @announcement.destroy
    
    redirect_to :back
  end
end

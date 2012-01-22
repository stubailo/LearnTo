class AnnouncementsController < ApplicationController
  def show
    @class_room = ClassRoom.find(params[:class_room_id])
    set_vars
    @announcements = @class_room.announcements
    render :layout => "layouts/show_class_room", :locals => {:which_tab => "home"}
  end
  
  def create
    
  end
  
  def ajaxDelete
    @announcement = Announcement.find(params[:announcement_id])
    if @post.user_id != current_user.id
      redirect_to root_url
    end
    @post.destroy
    return "ok"
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

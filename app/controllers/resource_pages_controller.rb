class ResourcePagesController < ApplicationController

  def show
	if current_user
	  @resource = Resource.new
	  @section = Section.new
	  @class_room = ClassRoom.find(params[:class_room_id])
	  @resource_page = ResourcePage.find(params[:id])
	  @sections = @resource_page.sections.sort_by { |hws| hws.order }
	  set_vars
      respond_to do |format|
		format.html { render :layout => "show_class_room", :locals => {:which_tab => @resource_page.section} }
		format.json { render json: @class_room }
	  end
    end
  end
  
  def set_vars
    @resource_pages = @class_room.resource_pages
    @creator = User.find(@class_room.creator_id)
    @user = current_user
    @user_permission = UserPermission.where("user_id = ? AND class_room_id = ?", @user.id, @class_room.id).first
    @users = @class_room.users
    if(!@user_permission)
      @user_permission = UserPermission.new
      @show_join = true
    end
  end  
  
end

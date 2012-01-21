class ResourcePagesController < ApplicationController

  def show
	if current_user
	  @resource = Resource.new
	  @section = Section.new
	  @class_room = ClassRoom.find(params[:class_room_id])
	  @resource_page = ResourcePage.find(params[:id])
	  @sections = @resource_page.sections.sort_by { |hws| hws.order }
	  @section = @sections.first
	  set_vars
      respond_to do |format|
		format.html { render :layout => "show_class_room", :locals => {:which_tab => @resource_page.section} }
		format.json { render json: @class_room }
	  end
    end
  end
  
end

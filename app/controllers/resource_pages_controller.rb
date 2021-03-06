class ResourcePagesController < ApplicationController
  def show
    @class_room = ClassRoom.find(params[:class_room_id])
    require_enrolled(@class_room)
  	if is_enrolled(@class_room)
  	  @resource_page = ResourcePage.find(params[:id])
      @sections = @resource_page.sections.sort_by { |sec| sec.order }
  	  errors = flash[:errors]
  	  @resource = Resource.new
  	  @resource.hidden = 1
  	  @section = Section.new
  	  set_vars
      respond_to do |format|
        format.html { render :layout => "show_class_room", :locals => {:which_tab => @resource_page.section} }
        format.json { render json: @class_room }
  	  end
    end
  end
end

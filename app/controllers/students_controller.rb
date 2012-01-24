class StudentsController < ApplicationController
  def show
    @class_room = ClassRoom.find(params[:class_room])
    @students = @class_room.users
    set_vars
    render :layout => "layouts/show_class_room", :locals => {:which_tab => "students"}
  end
end

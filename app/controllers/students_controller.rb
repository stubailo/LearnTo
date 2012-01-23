class StudentsController < ApplicationController
  def show
    @class_room = ClassRoom.find(params[:class_room])
    @students = @class_room.users
  end
end

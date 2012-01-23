class StudentsController < ApplicationController
  def show
    @class_room = params[:class_room]
    @students = @class_room.users
  end
end

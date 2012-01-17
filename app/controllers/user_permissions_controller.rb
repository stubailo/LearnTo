class UserPermissionsController < ApplicationController
  def destroy
    @user_permission=UserPermission.find(params[:id])
    @user = current_user
    @class_room = ClassRoom.find(@user_permission.class_room_id)
    if @user.id == @user_permission.user_id
	  @user_permission.destroy
	  redirect_to class_room_path(@class_room)
	else
	  redirect_to class_room_path(@class_room), :flash => { :fail => 'You can only remove yourself from a class' }
    end
  end

end

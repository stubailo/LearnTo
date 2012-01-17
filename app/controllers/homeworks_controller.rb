class HomeworksController < ApplicationController

	def index
	  if current_user
		@homework = Homework.new
		@resource = Resource.new
		@class_room = ClassRoom.find(params[:class_room_id])
		set_vars
		respond_to do |format|
			format.html { render :layout => "show_class_room" }
			format.json { render json: @class_room }
		end
	  end
	end
	
	def set_vars
		@creator = User.find(@class_room.creator_id)
		@user = current_user
		@users = @class_room.users
		@user_permission = UserPermission.where("user_id = ? AND class_room_id = ?", @user.id, @class_room.id).first
    end
	
	def show
	
	end
	
	def new
	
	end
	
	def create
	
	end
	
	def destroy
	
	end

end

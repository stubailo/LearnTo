class HomeworksController < ApplicationController

	def index
	  if current_user
		@resource = Resource.new
		@class_room = ClassRoom.find(params[:class_room_id])
		@homework_sections = @class_room.homework_sections.sort_by { |hws| hws.order }
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
	  @resource = Resource.new(params[:resource])
	  @class_room = ClassRoom.find(params[:class_room_id])
	  set_vars
	  
	  #Creates homework 
	  @homework = @class_room.homeworks.new
	  @homework.order = @class_room.homeworks.length
	  @homework_resource = HomeworkResource.new
	  
	  #set resource info not from form
	  @resource.source_call = "homework"
	  @resource.user_id = @user.id 
	  @resource.class_room_id = @class_room.id
	  
	  #deals with homework_sections
	  @homework_sections = @class_room.homework_sections
	  if(@homework_sections.length < 1)
	    @homework_section = HomeworkSection.new
	    @homework_section.title = "All Homework"
	    @homework_section.order = 0
	    if(@homework_section.save)
			#sets the homework's homework_section to all homework if there wasn't one when it was created
			@homework.homework_section_id = @homework_section.id
	    else
	      redirect_to class_room_homeworks_path(@class_room), :flash => { :fail => "You created your homework with an improper section." }
	    end
	  else
	    @homework.homework_section_id = @homework_sections.first.id
	  end
	  
	  #Makes the homework-resource relationship if the homework and resource are both valid -- need to put in validations
	  if(@resource.valid? && @homework.valid? && @homework_section.save)
	    @resource.save
	    @homework.save
	    @homework_resource.homework_id = @homework.id
	    @homework_resource.resource_id = @resource.id
	    @homework_resource.save
	    redirect_to class_room_homeworks_path(@class_room)
	  end
	
	end
	
	def destroy
	
	end

end

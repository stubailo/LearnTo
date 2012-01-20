class HomeworksController < ApplicationController

	def index
	  if current_user
		@resource = Resource.new
		@homework_section = HomeworkSection.new
		@class_room = ClassRoom.find(params[:class_room_id])
		@homework_sections = @class_room.homework_sections.sort_by { |hws| hws.order }
		set_vars
		respond_to do |format|
			format.html { render :layout => "show_class_room", :locals => {:which_tab => "homework"} }
			format.json { render json: @class_room }
		end
	  end
	end
	
	def set_vars
		@creator = User.find(@class_room.creator_id)
		@user = current_user
		@users = @class_room.users
		@user_permission = UserPermission.where("user_id = ? AND class_room_id = ?", @user.id, @class_room.id).first
		if(!@user_permission)
			@user_permission = UserPermission.new
			@show_join = true
		end
    end
	
	def show
	
	end
	
	def edit

	end
	
	def update
	
	end
	
	def new
	
	end
	
	def create
	  @resource = Resource.new(params[:resource])
	  @class_room = ClassRoom.find(params[:class_room_id])
	  homework_section_id = params[:homework_section][:id]
	  set_vars
	  
	  #Creates homework 
	  @homework = @class_room.homeworks.new
	  section = HomeworkSection.find(homework_section_id)
	  homeworks = section.homeworks.sort_by { |hw| hw.order }
	  @homework.order = homeworks.length>1? homeworks.last.order + 1 : 0
	  @homework_resource = HomeworkResource.new
	  @homework.homework_section_id = homework_section_id
	  
	  #set resource info not from form
	  @resource.source_call = "homework"
	  @resource.user_id = @user.id 
	  @resource.class_room_id = @class_room.id
	  @resource.hidden = false
	  
	  #handle documents
	  if @resource.file_type == "document"
	    @document = Document.new
	    @resource.hidden = true
	  end
	  
	  #Makes the homework-resource relationship if the homework and resource are both valid -- need to put in validations
	  if(@resource.valid? && @homework.valid?)
	    @resource.save
	    @homework.save
	    @homework_resource.homework_id = @homework.id
	    @homework_resource.resource_id = @resource.id
	    @homework_resource.save
	    if @resource.file_type == "document"
	      @document = Document.new
	      @resource.hidden = true
	      @document.resource_id = @resource.id
	      @document.dirty = false
	      @document.save
	      redirect_to edit_resource_path(@resource)
	    else
	      redirect_to class_room_homeworks_path(@class_room)
	    end
	  end
	
	end
	
	def create_section
	  @homework_section = HomeworkSection.new(params[:homework_section])
	  class_room = ClassRoom.find(params[:class_room_id])
	  homework_sections = class_room.homework_sections.sort_by { |hws| hws.order }
	  @homework_section.order = homework_sections.last.order + 1
	  @homework_section.class_room_id = class_room.id
	  if(@homework_section.save)
	    redirect_to class_room_homeworks_path(@class_room)
	  else
	    redirect_to class_room_homeworks_path(@class_room)
	  end
	end
	
	def destroy
	
	end

end

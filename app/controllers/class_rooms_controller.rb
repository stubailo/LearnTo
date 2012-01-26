class ClassRoomsController < ApplicationController
  # GET /class_rooms
  # GET /class_rooms.json
  def index
    @class_rooms = ClassRoom.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @class_rooms }
    end
  end
  
  
  def add_user
    @user = current_user
    @user_permission = UserPermission.new(params[:user_permission])
    @class_room = ClassRoom.find(@user_permission.class_room_id)
    if(!is_creator(@class_room) && !UserPermission.where("user_id = ? AND class_room_id = ?", @user.id, @class_room.id).first)
      @user_permission.user_id = @user.id
      @user_permission.permission_type = "student"
      respond_to do |format|
        if @user_permission.save
          format.html { redirect_to class_room_path(@class_room) , notice: 'Class joined successfully!' }
        else
          format.html { redirect_to class_rooms_path , flash => { :fail => 'Error joining class.' } }
        end
      end
    else
      redirect_to class_rooms_path , :flash => { :fail => 'You can\'t join a class more than once!' }
    end
  end
  
  def del_user
    @user_permission=UserPermission.find(params[:perm_id])
    @user = current_user
    @class_room = ClassRoom.find(@user_permission.class_room_id)
    if @user.id == @user_permission.user_id
      @user_permission.destroy
      redirect_to class_room_path(@class_room)
    else
      redirect_to class_room_path(@class_room), :flash => { :fail => 'You can only remove yourself from a class' }
    end
  end

  # GET /class_rooms/1
  # GET /class_rooms/1.json
  def show
    @class_room = ClassRoom.find(params[:id])
    @announcement = @class_room.announcements.order('created_at DESC').first
    @new_announcement = Announcement.new
    @description = @class_room.resource
    set_vars
      
    respond_to do |format|
      format.html { render :layout => "show_class_room", :locals => {:which_tab => "home"} }
      format.json { render json: @class_room }
    end
  end

  # GET /class_rooms/new
  # GET /class_rooms/new.json
  def new
    require_user
    if current_user
      @class_room = ClassRoom.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @class_room }
      end
    end
  end

  # GET /class_rooms/1/edit
  def edit
    @class_room = ClassRoom.find(params[:id])
  end

  # POST /class_rooms
  # POST /class_rooms.json
  def create
    @user = current_user
    @class_room = ClassRoom.new(params[:class_room])
    @class_room.user_id = @user.id
    @class_room.tag_line = @class_room.tag_line.upcase
    
    respond_to do |format|
      if @class_room.save
        ResourcePage::SECTIONS.each do |type|
          resource_page = ResourcePage.new(:class_room_id => @class_room.id, :section => type.capitalize)
          resource_page.save
          section = Section.new(:resource_page_id => resource_page.id, :order => 0, :title => "All " + type.capitalize)
          section.save
          if type == "materials"
            resource = Resource.new(:name => "Class Description", :user_id => @user.id, :class_room_id => @class_room.id,
              :file_type => "document", :source_call => "materials", :hidden => false, :order => 0, :section_id => section.id)
            resource.save
            document = Document.new(:resource_id => resource.id, :content => "Edit this document with a description of your class!", :parsed_content => "Edit this document with a description of your class!")
            document.save
            @class_room.update_attribute(:description_id, resource.id)
          end
        end
        forum = Forum.new(:class_room_id => @class_room.id)
        forum.save
        format.html { redirect_to @class_room, notice: 'Class was successfully created.' }
        format.json { render json: @class_room, status: :created, location: @class_room }
      else
        format.html { render action: "new" }
        format.json { render json: @class_room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /class_rooms/1
  # PUT /class_rooms/1.json
  def update
    @class_room = ClassRoom.find(params[:id])
    
    if is_creator(@class_room)

      respond_to do |format|
        if @class_room.update_attributes(params[:class_room])
          format.html { redirect_to @class_room, notice: 'Class was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @class_room.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_back_or_default @class_room
    end
  end

  # DELETE /class_rooms/1
  # DELETE /class_rooms/1.json
  def destroy
    @user = current_user
    @class_room = ClassRoom.find(params[:id])
    if is_creator(@class_room)
      @class_room.destroy
      
      respond_to do |format|
        format.html { redirect_to root_path }
        format.json { head :no_content }
      end
    else
      redirect_to class_room_path(@class_room), :flash => { :fail => "You do not have permission to modify this class." }
    end
  end

  def plus1
    class_room = ClassRoom.where(:id => params[:id]).first
    rating = class_room.class_room_ratings.where(:user_id => current_user.id).first
    if rating == nil
      rating = ClassRoomRating.new(:user_id => current_user.id, :class_room_id => params[:id], :value => 1)
    elsif rating.value == 0
      rating.value = 1
    elsif rating.value == 1
      rating.value = 0
    else
      rating.value = 1
    end
    rating.save
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { render :json => {:rating => rating } }
    end
  end
  
  def minus1
    class_room = ClassRoom.where(:id => params[:id]).first
    rating = class_room.class_room_ratings.where(:user_id => current_user.id).first
    if rating == nil
      rating = ClassRoomRating.new(:user_id => current_user.id, :class_room_id => params[:id], :value => -1)
    elsif rating.value == 0
      rating.value = -1
    elsif rating.value == -1
      rating.value = 0
    else
      rating.value = -1
    end
    rating.save
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { render :json => {:rating => rating } }
    end
  end
  
  def search
    @class_rooms = ClassRoom.search(params[:search_term], params[:search] ? params[:search][:category] : nil).sort_by { |class_room| class_room.updated_at }.reverse
  end
  
end

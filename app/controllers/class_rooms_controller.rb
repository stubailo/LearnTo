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
    @class_room = ClassRoom.find(params[:id])
  end

  # GET /class_rooms/1
  # GET /class_rooms/1.json
  def show
    @class_room = ClassRoom.find(params[:id])
    @creator = User.find(@class_room.creator_id)
    @user = current_user

    respond_to do |format|
      format.html # show.html.erb
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
    @class_room.creator_id = @user.id 

    respond_to do |format|
      if @class_room.save
        format.html { redirect_to @class_room, notice: 'Class room was successfully created.' }
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

    respond_to do |format|
      if @class_room.update_attributes(params[:class_room])
        format.html { redirect_to @class_room, notice: 'Class room was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @class_room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /class_rooms/1
  # DELETE /class_rooms/1.json
  def destroy
    @user = current_user
    @class_room = ClassRoom.find(params[:id])
    if @class_room.creator_id == @user.id
	  @class_room.destroy
	  	
	  respond_to do |format|
	    format.html { redirect_to class_rooms_url }
	    format.json { head :no_content }
	  end
	else
	  redirect_to class_room_path(@class_room), :notice => "You do not have permission to modify this person's class"
	end
  end
end

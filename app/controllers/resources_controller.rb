class ResourcesController < ApplicationController
  # GET /resources
  # GET /resources.json
  def index
    @resources = Resource.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @resources }
    end
  end

  def set_vars
    @creator = User.find(@class_room.creator_id)
	@user = current_user
	@users = @class_room.users
	@user_permission = UserPermission.where("user_id = ? AND class_room_id = ?", @user.id, @class_room.id).first
  end
	

  # GET /resources/1
  # GET /resources/1.json
  def show
    @resource = Resource.find(params[:id])
    @class_room = ClassRoom.find(@resource.class_room_id)
    set_vars

    respond_to do |format|
	  format.html { render :layout => "show_class_room", :locals => {:which_tab => "homework"} }
	  format.json { render json: @resource }
	end
  end

  # GET /resources/new
  # GET /resources/new.json
  def new
	require_user
	
		if current_user
			@resource = Resource.new

			respond_to do |format|
				format.html # new.html.erb
				format.json { render json: @resource }
			end
		end
  end

  # GET /resources/1/edit
  def edit
    @resource = Resource.find(params[:id])
    @class_room = ClassRoom.find(@resource.class_room_id)
    set_vars
    if(@resource.file_type == "document")
      @document = @resource.document
    end
    respond_to do |format|
	  format.html { render :layout => "show_class_room", :locals => {:which_tab => "homework"} }
	  format.json { render json: @resource }
	end
  end

  # POST /resources
  # POST /resources.json
  def create
    @resource = Resource.new(params[:resource])
    @user = current_user
    @resource.user_id = @user.id
    if @resource.file_file_name
      @resource.file_type = @resource.file.content_type
      @resource.url = @resource.file.url
    else
      @resource.file_type = "internet"
    end
    #@resource.file_file_name = + user id


    respond_to do |format|
      if @resource.save
        format.html { redirect_to @resource, :flash => { :fail => 'Resource was successfully created.' } }
        format.json { render json: @resource, status: :created, location: @resource }
      else
        format.html { render action: "new" }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /resources/1
  # PUT /resources/1.json
  def update
    @resource = Resource.find(params[:id])

    respond_to do |format|
      if @resource.update_attributes(params[:resource])
        if(@resource.file_type == "document")
          @document = @resource.document
          @document.content = params[:document][:content]
          @document.dirty = true
          @document.save
        end
        format.html { redirect_to @resource, notice: 'Resource was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resources/1
  # DELETE /resources/1.json
  def destroy
    @resource = Resource.find(params[:id])
    @resource.destroy

    respond_to do |format|
      format.html { redirect_to resources_url }
      format.json { head :no_content }
    end
  end
end

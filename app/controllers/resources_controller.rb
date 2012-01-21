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

  def get_path_vars	
    @class_room = ClassRoom.find(params[:class_room_id])
    @section = Section.find(params[:section_id])
    @resource_page = ResourcePage.find(params[:resource_page_id])
  end

  # GET /resources/1
  # GET /resources/1.json
  def show
    @resource = Resource.find(params[:id])
    get_path_vars
    set_vars

    respond_to do |format|
      format.html { render :layout => "show_class_room", :locals => {:which_tab => @resource_page.section} }
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
    get_path_vars
    set_vars
    if(@resource.file_type == "document")
      @document = @resource.document
    end
    if @resource.source_call == "homework"
      respond_to do |format|
	    format.html { render :layout => "show_class_room", :locals => {:which_tab => @resource_page.section} }
	    format.json { render json: @resource }
	  end
	end
  end

  # POST /resources
  # POST /resources.json
  def create
	@resource = Resource.new(params[:resource])
	@class_room = ClassRoom.find(params[:class_room_id])
    @resource_page = ResourcePage.find(params[:resource_page_id])
    @section = Section.find(params[:section][:id])
    set_vars

	#set resource info not from form
	@resource.source_call = @resource_page.section
	@resource.user_id = @user.id 
	@resource.class_room_id = @class_room.id
	@resource.section_id = @section.id
	@resource.hidden = false
	  
	#handle documents
	if @resource.file_type == "document"
	  @document = Document.new
	  @resource.hidden = true
	end
	  
	#Makes the homework-resource relationship if the homework and resource are both valid -- need to put in validations
    if @resource.save
      unless @resource.hidden
        @class_room.update_attribute(:updated_at, Time.now.to_datetime)
      end
      if @resource.file_type == "document"
	    @document = Document.new
	    @document.resource_id = @resource.id
	    @document.dirty = false
	    @document.save
	    redirect_to edit_class_room_resource_page_section_resource_path(@class_room, @resource_page, @section, @resource)
	  else
	    redirect_to class_room_resource_page_path(@class_room, @resource_page)
	  end
	else
	  redirect_to class_room_resource_page_path(@class_room, @resource_page)
	end
  end

  # PUT /resources/1
  # PUT /resources/1.json
  def update
    @resource = Resource.find(params[:id])
    @class_room = ClassRoom.find(@resource.class_room_id)
    @resource_page = ResourcePage.find(params[:resource_page_id])
    @section = Section.find(params[:section_id])

    respond_to do |format|
      if @resource.update_attributes(params[:resource])
        if(@resource.file_type == "document")
          @document = @resource.document
          @document.content = params[:document][:content]
          @document.dirty = true
          @document.save
        end
        unless @resource.hidden
          @class_room.update_attribute(:updated_at, Time.now.to_datetime)
        end
        format.html { redirect_to class_room_resource_page_section_resource_path(@class_room, @resource_page, @section, @resource),
         notice: 'Resource was successfully updated.' }
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

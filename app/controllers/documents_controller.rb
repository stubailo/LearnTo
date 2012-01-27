class DocumentsController < ApplicationController
  def create_doc_rec
		@path_resource = Resource.find(params[:resource_id])
		@new_resource = Resource.new(params[:resource])
		@class_room = ClassRoom.find(params[:class_room_id])
		@resource_page = ResourcePage.find(params[:resource_page_id])
		@section = Section.find(params[:section_id])
		@document = Document.find(params[:id])
	  set_vars
	  if @is_creator
	    if params[:resource]
				#set resource info not from form
				@new_resource.source_call = "document"
				@new_resource.document_id = @document.id
				@new_resource.hidden = false
					
				#Makes the document-resource relationship if the document and resource are both valid -- need to put in validations
				if @new_resource.save
          respond_to do |format|
					  format.html { redirect_to edit_class_room_resource_page_section_resource_path(@class_room, @resource_page, @section, @path_resource) }
            format.json { render :json => @new_resource.to_json }
          end
				end
		  else
				redirect_to edit_class_room_resource_page_section_resource_path(@class_room, @resource_page, @section, @path_resource), :flash => { :fail => "Error embedding resource.."}
			end
		else
		  redirect_to class_room_resource_page_path(@class_room, @resource_page), :flash => { :fail => "You must be the owner of this class to upload resources"}
		end
  end
end

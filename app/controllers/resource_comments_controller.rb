class ResourceCommentsController < ApplicationController

  def create
    @resource_comment = ResourceComment.new(params[:resource_comment])
    comments = Resource.find(params[:resource_id]).resource_comments
    @resource_comment.resource_id = params[:resource_id]
    @resource_comment.user_id = current_user.id
    @resource_comment.save
   
    @class_room = @resource_comment.resource.class_room
    set_vars
    @section = @resource_comment.resource.section
    @resource_page = @section.resource_page
    @resource = @resource_comment.resource 
    
    comments.each do |comment|
      if comment.user_id != @class_room.user_id && comment.user_id != current_user.id
        user_notification("also_resource_comment","ResourceComment", comment.user, 
          @resource_comment.id, @resource_comment.resource_id)
      end
    end
    
    user_notification("new_resource_comment","ResourceComment", @resource_comment.resource.user, 
          @resource_comment.id, @resource_comment.resource.id)
   
    #return in json, with html for new form and for new comment, using the partials in resource comments
    respond_to do |format|
      format.json { render :json => { :comment_html => render_to_string( :partial => "resource_comment.html.haml", :locals => { :resource_comment => @resource_comment }  )} }
      format.html { redirect_to :back }
    end
  end

  def destroy
    @resource_comment = ResourceComment.find(params[:id])
    if @resource_comment.user_id != current_user.id and current_user.id != @resource_comment.resource.class_room.user_id
      redirect_to root_url
    end
    @resource_comment.destroy
    redirect_to :back
  end
end

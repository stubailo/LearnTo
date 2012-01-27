class ResourceCommentsController < ApplicationController
  def new
    @resource_comment = ResourceComment.new
  end

  def create
    @resource_comment = ResourceComment.new(params[:resource_comment])
    @resource_comment.resource_id = params[:resource_id]
    @resource_comment.user_id = current_user.id
    @resource_comment.save
   
    #return in json, with html for new form and for new comment, using the partials in resource comments

    redirect_to :back
  end

  def destroy
    @resource_comment = ResourceComment.find(params[:id])
    if @resource_comment.user_id != current_user.id
      redirect_to root_url
    end
    @resource_comment.destroy
    redirect_to :back
  end
end

class SubcommentsController < ApplicationController
  def new
    @subcomment = Subcomment.new
  end

  def create
    @subcomment = Subcomment.new(params[:subcomment])
    @subcomment.comment_id = params[:comment_id]
    @subcomment.user_id = current_user.id
    @subcomment.save
    
    redirect_to :back
  end

  def destroy
    @subcomment = Subcomment.find(params[:subcomment_id])
    @subcomment.destroy
    redirect_to :back
  end
end

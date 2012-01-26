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
    @subcomment = Subcomment.find(params[:id])
    if @subcomment.user_id != current_user.id
      redirect_to root_url
    end
    @subcomment.destroy
    redirect_to :back
  end
end

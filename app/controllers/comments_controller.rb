class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(params[:comment])
    @comment.post_id = params[:post_id]
    @comment.user_id = current_user.id
    @comment.save
    redirect_to root_url + "forums/"+ params[:forum_id]
  end

  def destroy
    @comment = Comment.find(params[:comment_id])
    @comment.destroy
    redirect_to root_url + "forums/" + params[:forum_id]
  end
  
  def plus1
    rating = Rating.where("user_id = ? AND comment_id = ?", current_user.id, params[:comment_id]).first
    if rating != nil
      rating.value = 1
    else
      rating = Rating.new(:user_id => current_user.id, :comment_id => params[:comment_id], :value => 1)
    end
    rating.save
    redirect_to root_url + "forums/" + params[:forum_id]
  end
  
  def minus1
    rating = Rating.where("user_id = ? AND comment_id = ?", current_user.id, params[:comment_id]).first
    if rating != nil
      rating.value = -1
    else
      rating = Rating.new(:user_id => current_user.id, :comment_id => params[:comment_id], :value => -1)
    end
    rating.save
    redirect_to root_url + "forums/" + params[:forum_id]
  end
end

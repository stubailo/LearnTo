class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(params[:comment])
    @post = Post.find(params[:post_id])
    @comment.post_id = @post.id
    @comment.user_id = current_user.id
    if @comment.save
      @post.last_updated = Time.now
    end
    
    redirect_to :back
  end

  def destroy
    @comment = Comment.find(params[:comment_id])
    if @comment.user_id != current_user.id
      redirect_to root_url
    end
    @comment.destroy
    redirect_to :back
  end
  
  def plus1
    rating = Rating.where("user_id = ? AND comment_id = ?", current_user.id, params[:comment_id]).first
    if rating != nil
      rating.value = 1
    else
      rating = Rating.new(:user_id => current_user.id, :comment_id => params[:comment_id], :value => 1)
    end
    rating.save
    redirect_to :back
  end
  
  def minus1
    rating = Rating.where("user_id = ? AND comment_id = ?", current_user.id, params[:comment_id]).first
    if rating != nil
      rating.value = -1
    else
      rating = Rating.new(:user_id => current_user.id, :comment_id => params[:comment_id], :value => -1)
    end
    rating.save
    redirect_to :back
  end
end

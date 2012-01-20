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
      @rating = Rating.new(:user_id => current_user.id, :comment_id => @comment.id, :value => 1)
      @rating.save
      @post.save
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
  
  def ajaxEdit
    id = params[:id]
    content = params[:content]
    
    @comment = Comment.find(params[:id])
    @comment.content = content
    @comment.save
  end
  
  def ajaxCreate
    @post = Post.find(params[:post_id])
    
    @comment = Comment.new
    @comment.content = params[:comment_text]
    @comment.post_id = @post.id
    @comment.user_id = current_user.id
    
    if @comment.save
      @post.last_updated = Time.now
      @post.save
    end
    return "ok"
  end
  
  def ajaxDelete
    @comment = Comment.find(params[:comment_id])
    if @comment.user_id != current_user.id
      redirect_to root_url
    end
    @comment.destroy
    return "ok"
  end
  
  def plus1
    rating = Rating.where("user_id = ? AND comment_id = ?", current_user.id, params[:comment_id]).first
    if rating != nil
      rating.value = 1
    else
      rating = Rating.new(:user_id => current_user.id, :comment_id => params[:comment_id], :value => 1)
    end
    rating.save
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { render :json => {:rating => Comment.find(params[:comment_id]).rating } }
    end
  end
  
  def minus1
    rating = Rating.where("user_id = ? AND comment_id = ?", current_user.id, params[:comment_id]).first
    if rating != nil
      rating.value = -1
    else
      rating = Rating.new(:user_id => current_user.id, :comment_id => params[:comment_id], :value => -1)
    end
    rating.save
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { render :json => {:rating => Comment.find(params[:comment_id]).rating } }
    end
  end
end

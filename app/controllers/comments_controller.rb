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
      @rating = PostRating.new(:user_id => current_user.id, :comment_id => @comment.id, :value => 0)
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
    
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { render :json => {:comment => @comment } }
    end
    
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
    rating = PostRating.where("user_id = ? AND comment_id = ?", current_user.id, params[:comment_id]).first
    if rating == nil
      rating = PostRating.new(:user_id => current_user.id, :comment_id => params[:comment_id], :value => 1)
    elsif rating.value = 0
      rating.value = 1
    elsif rating.value == 1
      rating.value = 0
    else
      #some type of error
    end
    rating.save
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { render :json => {:rating => rating } }
    end
  end
  
  def minus1
    rating = PostRating.where("user_id = ? AND comment_id = ?", current_user.id, params[:comment_id]).first
    if rating == nil
      rating = PostRating.new(:user_id => current_user.id, :comment_id => params[:comment_id], :value => 1)
    elsif rating.value = 0
      rating.value = -1
    elsif rating.value == -1
      rating.value = 0
    else
      #some type of error
    end
    rating.save
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { render :json => {:rating => rating } }
    end
  end
end
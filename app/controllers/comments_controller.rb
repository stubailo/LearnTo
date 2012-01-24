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
    
    respond_to do |format|
       if @comment.save
        format.html  { redirect_to(@comment, :notice => 'Comment was successfully created.') }
        partial = render_to_string :partial => "comments/comment", :locals => {:comment => @comment}
        format.json  { render :json => {:new_comment => partial} }
      else
        format.html  { render :back }
        format.json  { render :json => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:comment_id])
    if @comment.user_id != current_user.id
      redirect_to root_url
    end
    @comment.destroy
    redirect_to :back
  end
  
  def edit
    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html  { redirect_to(@comment, :notice => 'Comment was successfully updated.') }
        partial = render_to_string :partial => "comments/comment", :locals => {:comment => @comment}
        format.json  { render :json => {:updated_comment => partial} }
      else
        format.html  { render :back }
        format.json  { render :json => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def plus1
    rating = PostRating.where("user_id = ? AND comment_id = ?", current_user.id, params[:comment_id]).first
    if rating == nil
      rating = PostRating.new(:user_id => current_user.id, :comment_id => params[:comment_id], :value => 1)
    elsif rating.value == 0
      rating.value = 1
    elsif rating.value == 1
      rating.value = 0
    else
      rating.value = 1
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
    elsif rating.value == 0
      rating.value = -1
    elsif rating.value == -1
      rating.value = 0
    else
      rating.value = -1
    end
    rating.save
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { render :json => {:rating => rating } }
    end
  end
end

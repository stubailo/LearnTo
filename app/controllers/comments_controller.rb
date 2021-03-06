class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(params[:comment])
    @post = Post.find(params[:post_id])
    @forum = @post.forum
    @class_room = @forum.class_room
    @comment.post_id = @post.id
    @comment.user_id = current_user.id
    
    if @comment.save
      @post.last_updated = Time.now
      @rating = PostRating.new(:user_id => current_user.id, :comment_id => @comment.id, :value => 0)
      @rating.save
      @post.save
      user_notification("new_comment","Comment",@post.user,@comment.id, @post.id)
    end
    
    respond_to do |format|
       if @comment.save
        format.html  { redirect_to(@comment, :notice => 'Comment was successfully created.') }
        partial = render_to_string :partial => "comments/comment.html.haml", :locals => {:comment => @comment}
        format.json  { render :json => {:new_comment => partial} }
      else
        format.html  { render :back }
        format.json  { render :json => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @class_room = ClassRoom.find(params[:class_room_id])
    if @comment.user_id != current_user.id && !is_creator(@class_room)
      flash[:fail] = "You do not have permission to delete that"
      redirect_to root_url
    else
      @comment.destroy
      redirect_to :back
    end
  end
  
  def update
    @class_room = ClassRoom.find(params[:class_room_id])
    @forum = Forum.find(params[:forum_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html  { redirect_to([@class_room, @forum, @post], :notice => 'Comment was successfully updated.') }
        partial = render_to_string :partial => "comments/comment", :locals => {:comment => @comment}
        format.json  { render :json => {:updated_comment => partial} }
      else
        format.html  { render :back }
        format.json  { render :json => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def plus1
    comment = Comment.where(:id => params[:id]).first
    rating = comment.post_ratings.where(:user_id => current_user.id).first
    if rating == nil
      rating = PostRating.new(:user_id => current_user.id, :comment_id => params[:id], :value => 1)
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
      format.json { render :json => {:rating => comment.rating } }
    end
  end
  
  def minus1
    comment = Comment.where(:id => params[:id]).first
    rating = comment.post_ratings.where(:user_id => current_user.id).first
    if rating == nil
      rating = PostRating.new(:user_id => current_user.id, :comment_id => params[:id], :value => 1)
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
      format.json { render :json => {:rating => comment.rating } }
    end
  end
end

class PostsController < ApplicationController
  def index
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  def show
    @edit_post = Post.new
    @edit_comment = Comment.new
    @post = Post.find(params[:id])
    @forum = @post.forum
    if @post
      @subcomment = Subcomment.new
      @comment = Comment.new
      @user = current_user
      @class_room = @forum.class_room
      set_vars
      render :layout => "layouts/show_class_room", :locals => {:which_tab => "discussion"}
    else
      redirect_to :back
    end
  end

  def edit
    respond_to do |format|
      if @post.update_attributes(params[:post_id])
        format.html  { redirect_to(@post, :notice => 'Post was successfully updated.') }
        partial = render_to_string :partial => "posts/post", :locals => {:post => @post}
        format.json  { render :json => {:updated_post => partial} }
      else
        format.html  { render :back }
        format.json  { render :json => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  def create
    @post = Post.new(params[:post])
    @post.forum_id = params[:forum_id]
    @post.user_id = current_user.id
    @post.last_updated = Time.now
    tag_list = params[:new_tags].split(/[\s,]+/)
    tag_list.map do |x|
      if x[0,1] == "#"
        x = x.downcase
      else
        x = x.insert(0,"#").downcase
      end
    end
    @post.tag_list = tag_list
    @post.save
    respond_to do |format|
      if @post.save
        format.html  { redirect_to :back }
        partial = render_to_string :partial => "posts/post", :locals => {:post => @post, :forum => @post.forum}
        format.json  { render :json => {:new_post => partial} }
      else
        format.html  { render :back }
        format.json  { render :json => @post.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def posts_since_datetime
    @ids = current_user.class_rooms.map {|x| x.id}
    dateTime = DateTime.parse(params[:date_time])
    @posts = Post.where("last_updated > ? AND id IN (?)", dateTime, @ids).order(:created_at)
    respond_to do |format|
      format.json { render json: @posts }
    end
  end

  def destroy
    @post = Post.find(params[:id]) 
    @forum = @post.forum 
    if @post.user_id != current_user.id or current_user.id == @post.forum.class_room.user.id
      redirect_to root_url
    end
    @post.destroy
    redirect_to forum_path(@forum)
  end
end









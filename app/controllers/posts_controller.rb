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
    @class_room = @forum.class_room
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

  def update
    @post = Post.find(params[:id])
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html  { redirect_to class_room_forum_post_path(params[:class_room_id], params[:forum_id], @post), :notice => 'Post was successfully updated.' }
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
    @class_room = @forum.class_room
    if @post.user_id != current_user.id && !is_creator(@class_room)
      flash[:fail] = "You do not have permission to delete that"
      redirect_to root_url
    else
			@post.destroy
			redirect_to class_room_forum_path(@class_room, @forum)
		end
  end
end









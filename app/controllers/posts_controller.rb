class PostsController < ApplicationController

  def index
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  def show
    @post = Post.find(params[:id])
    @forum = Forum.find(@post.forum_id)
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
      if @post.update_attributes(params[:post])
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
    @post.forum_id = params[:forum_id]
    @post.last_updated = Time.now
    respond_to do |format|
      if @post.save
        format.html  { redirect_to(@post, :notice => 'Post was successfully created.') }
        partial = render_to_string :partial => "posts/post", :locals => {:post => @post}
        format.json  { render :json => {:new_post => partial} }
      else
        format.html  { render :back }
        format.json  { render :json => @post.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def since_datetime
    posts = []
    current_user.class_rooms.each do |x|
      posts += x.forum.posts.where("created_at > ?", DateTime.parse(params[:datetime]))
    end
    posts.sort_by! { |post| post.created_at}.reverse!
  end

  def destroy
    @post = Post.find(params[:id])   
    @forum_id = @post.forum_id 
    if @post.user_id != current_user.id
      redirect_to root_url
    end
    @post.destroy
    redirect_to forum_path(@forum_id)
  end
  
end









class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
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

  # GET /posts/1/edit
  def edit
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html  { redirect_to(@post, :notice => 'Post was successfully updated.') }
        format.json  { render :html => @post }
      else
        format.html  { render :back }
        format.json  { render :json => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    @post.forum_id = params[:forum_id]
    @post.user_id = current_user.id
    @post.forum_id = params[:forum_id]
    @post.last_updated = Time.now
    @post.save
    respond_to do |format|
      if @post.save
        format.html  { redirect_to(@post, :notice => 'Post was successfully created.') }
        format.json  { render :html => @post }
      else
        format.html  { render :back }
        format.json  { render :json => @post.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /posts/1
  # DELETE /posts/1.json
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









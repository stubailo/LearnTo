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

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end
  
  def ajaxEdit
    id = params[:id]
    title = params[:title]
    content = params[:content]
    
    @post = Post.find(params[:id])
    @post.title = title
    @post.content = content
    @post.save
    
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { render :json => {:post => @post } }
    end
  end
  
  def ajaxDelete
    @post = Post.find(params[:post_id])
    if @post.user_id != current_user.id
      redirect_to root_url
    end
    @post.destroy
    return "ok"
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
    redirect_to :back
  end


  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:post_id])   
    @forum_id = @post.forum_id 
    if @post.user_id != current_user.id
      redirect_to root_url
    end
    @post.destroy
    
    redirect_to forum_path(@forum_id)
  end
  
end









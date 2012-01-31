class ForumsController < ApplicationController
  def show
    if false
      consumer_key = "jjCZcGGsUENc4vAX5ODwA"
      consumer_secret = "hIKoUyLw7AK8jECwA3V01U28wMPvd3db8Y1nG77MIZc"
      consumer = OAuth::Consumer.new(consumer_key, consumer_secret,
                                     :site => "http://api.justin.tv",
                                     :request_token_path => "/oauth/request_token",
                                     :authorize_path => "/oauth/authorize",
                                     :access_token_path => "/oauth/access_token",
                                     :http_method => :get)
  
      # make the access token from your consumer
      access_token = OAuth::AccessToken.new consumer
      
      #@test = access_token.get("/application/rate_limit_status.xml")
      
      # make a signed request!
      @test_create = access_token.post "/api/user/create.xml", {"login" => "jtwarren", "password" => "testtest", "birthday" => "1990-15-1990", "email" => "jtwarren@mit.edu"}
    end

    @forum = Forum.find(params[:id])
    @class_room = @forum.class_room
    require_enrolled(@class_room)
    if is_enrolled(@class_room)
      @posts = @forum.posts.order("last_updated DESC").page(params[:page]).per(15)
      set_vars
        
      if @forum != nil && @user != nil
        @post = Post.new
        @comment = Comment.new
        render :layout => "layouts/show_class_room", :locals => {:which_tab => "discussion"}
      else
        redirect_to :back
      end
    end
  end
  
  def search
    @post = Post.new
    @posts = Post.search(params[:search_term], params[:id])
    @forum = Forum.find(params[:id])
    @class_room = @forum.class_room
    set_vars
    render :layout => "layouts/show_class_room", :locals => {:which_tab => "discussion"}
  end
  
  def search_by_tag
    @posts = Post.search_by_tag(params[:tag_term], params[:id])
    @forum = Forum.find(params[:id])
    @class_room = @forum.class_room
    set_vars
    render 'search', :layout => "layouts/show_class_room", :locals => {:which_tab => "discussion"}
  end
end


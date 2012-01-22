class ForumsController < ApplicationController
  def show 
    @forum = Forum.find(params[:id])
    @class_room = @forum.class_room
    @tags = []
    @ids = []
    set_vars
    
    Post.select(:id).where(:forum_id => @forum.id).each { |x| @ids.push(x.id) }
    
    Tagging.select("\"tag_id\" as tag_id, max(\"created_at\") as created_at,max(\"taggable_type\") as taggable_type,max(\"context\") as context")
     .where(:taggable_type => "Post")
     .where(:taggable_id => @ids)
     .group("tag_id")
     .order('created_at DESC')
     .limit(6).each { |x| @tags.push(x.tag.name) }
      
    if @forum != nil && @user != nil
      @post = Post.new
      @comment = Comment.new
      @posts = Post.where('forum_id = ?', @forum.id).order("last_updated DESC")
      render :layout => "layouts/show_class_room", :locals => {:which_tab => "discussion"}
    else
      redirect_to :back
    end
  end
  
  def search
    @posts = Post.search(params[:search_term], params[:forum_id])
    @forum = Forum.find('1')
    @class_room = @forum.class_room
    set_vars
    render :layout => "layouts/show_class_room", :locals => {:which_tab => "discussion"}
  end
  
  def search_by_tag
    @posts = Post.search_by_tag(params[:tag_term], params[:forum_id])
    @forum = Forum.find(params[:forum_id])
  end
end


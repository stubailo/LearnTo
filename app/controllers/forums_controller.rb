class ForumsController < ApplicationController
  def show
    @forum = Forum.find(:all, :conditions => ['class_room_id = ?', params[:id]]).first
    @class_room = ClassRoom.find(params[:id])
    @tags = []
    @ids = []

    set_vars

    Post.select(:id).where(:forum_id => @forum.id).each do |x|
      @ids.push(x.id)
    end
    
    Tagging.select("tag_id as 'tag_id',max(created_at) as 'created_at',taggable_type as 'taggable_type',context as 'context'")
    .where(:taggable_type => "Post")
    .where(:taggable_id => @ids)
    .order("created_at DESC")
    .group("tag_id").limit(6)

    if @forum != nil && @user != nil
      @post = Post.new
      @comment = Comment.new
      @posts = Post.find(:all, :conditions => ['forum_id = ?', @forum.id])
      render :layout => "layouts/show_class_room", :locals => {:which_tab => "discussion"}
    else
      redirect_to :back
    end
  end

  def set_vars
    @creator = User.find(@class_room.creator_id)
    @user = current_user
    @users = @class_room.users
    @user_permission = UserPermission.where("user_id = ? AND class_room_id = ?", @user.id, @class_room.id).first
  end


end


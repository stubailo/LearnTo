class ForumsController < ApplicationController
  def show
    @forum = Forum.find(:all, :conditions => ['id = ?', params[:id]]).first
    @user = current_user
    @tags = []
    @ids = []
    Post.select(:id).where(:forum_id => @forum.id).each do |x|
      @ids.push(x.id)
    end
   Tagging.select("tag_id as 'tag_id',max(created_at) as 'created_at',taggable_type as 'taggable_type',context as 'context'")
    .where(:taggable_type => "Post")
    .where(:taggable_id => @ids)
    .order("created_at DESC")
    .group("tag_id").limit(6).each do |x|
      @tags.push(x.tag.name).sort!
    end

    if @forum != nil && @user != nil
      @post = Post.new
      @comment = Comment.new
      @posts = Post.find(:all, :conditions => ['forum_id = ?', @forum.id])
    else
      redirect_to :back
    end
  end
end

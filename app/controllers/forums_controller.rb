class ForumsController < ApplicationController
  def show
    @tags = []
    Tagging.select("tag_id as 'tag_id',max(created_at) as 'created_at',taggable_type as 'taggable_type',context as 'context'").order("created_at DESC").group("tag_id").limit(6).each do |tagging|
      @tags.push(tagging.tag)
    end
    @user = current_user
    @forum = Forum.find(:all, :conditions => ['id = ?', params[:id]]).first
    if @forum != nil && @user != nil
      @post = Post.new
      @comment = Comment.new
      @posts = Post.find(:all, :conditions => ['forum_id = ?', @forum.id])
    else
      redirect_to :back
    end
  end
end
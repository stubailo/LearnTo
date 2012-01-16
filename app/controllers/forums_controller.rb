class ForumsController < ApplicationController
  def show
    @forum = Forum.find(:all, :conditions => ['id = ?', params[:id]]).first
    if @forum != nil
      @post = Post.new
      @comment = Comment.new
      @posts = Post.find(:all, :conditions => ['forum_id = ?', @forum.id])
    else
      redirect_to root_url  #TODO:Fix this shit
    end
  end
end

class ForumsController < ApplicationController
  def show
    @user = current_user
    @forum = Forum.find(:all, :conditions => ['id = ?', params[:id]]).first
    if @forum != nil && @user != nil
      @post = Post.new
      @comment = Comment.new
      @posts = Post.find(:all, :conditions => ['forum_id = ?', @forum.id])
    else
      redirect_to root_url  #TODO:Fix this shit, this happens if the forum doesnt exist or if the user isnt logged in
    end
  end
end

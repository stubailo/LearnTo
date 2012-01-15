class ForumController < ApplicationController
  def show
    @posts = Post.all #for now, add where clause where class = class or something?	
  end
end

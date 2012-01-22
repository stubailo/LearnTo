class HomeController < ApplicationController

  def index
    @posts = []
    @announcements = []
  	if current_user
  		@user = current_user
  		@class_rooms = @user.class_rooms.sort_by { |class_room| class_room.updated_at }.reverse
  		@user.class_rooms.each do |classroom|
  		  @posts += classroom.forum.posts.limit(6) 
  		  @announcements += classroom.announcements.order('created_at DESC').limit(1)
  		end
  		@posts.sort_by! { |post| post.last_updated}.reverse!.first(6)
  		@announcements.sort_by! { |a| a.created_at}.reverse!.first(6)
  		
  	end
  end        

  def media_test
  	if current_user
  		@user = current_user
  	end
  end

end


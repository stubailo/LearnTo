class HomeController < ApplicationController

  def index
	if current_user
		@user = current_user
		@class_rooms = @user.class_rooms.sort_by { |class_room| class_room.updated_at }.reverse
		@posts = []
		@user.class_rooms.each { |classroom| @posts += classroom.forum.posts.limit(6)}
		@posts.sort_by! { |post| post.last_updated}.reverse!
	end
  end        

  def media_test
	if current_user
		@user = current_user
	end
  end

end


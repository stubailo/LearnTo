class HomeController < ApplicationController

  def index
    @posts = []
    @announcements = []
    @resources = []
    
    #If there is a user logged in
  	if current_user
  		@user = current_user
  		@class_rooms = @user.class_rooms.sort_by { |class_room| class_room.updated_at }.reverse
  		@user.class_rooms.each do |classroom|
  		  @resources += classroom.resources.limit(10).sort_by { |res| res.updated_at }.reverse
  		  @posts += classroom.forum.posts.order('created_at DESC').limit(10)
  		  @announcements += classroom.announcements.order('created_at DESC').limit(6)
  		end
  		@posts = @posts.sort_by! { |post| post.created_at}.reverse!.first(10)
  		@announcements = @announcements.sort_by! { |a| a.created_at}.reverse!.first(6)      
    #There is no user logged in
    else
      @random_class_room = random
      render :action => "index"
      return
    end
    @random_class_room = random
    render :action => "user_index"
  end        
  
  def teacher_index
    @posts = []
    @announcements = []
    @resources = []
    
    #If there is a user logged in
    if current_user
      @user = current_user
      @class_rooms = @user.taught_classes.sort_by { |class_room| class_room.updated_at }.reverse
      @user.taught_classes.each do |classroom|
        @resources += classroom.resources.limit(10).sort_by { |res| res.updated_at }.reverse
        @posts += classroom.forum.posts.order('created_at DESC').limit(10)
      end
      @posts = @posts.sort_by! { |post| post.created_at}.reverse!.first(10)
      @announcements = @announcements.sort_by! { |a| a.created_at}.reverse!.first(6)      
    #There is no user logged in
    else
      render :action => "index"
      return
    end
    render :action => "teacher_index"
  end        


  def media_test
  	if current_user
  		@user = current_user
  	end
  end
  
  def random
    ids = []
    ClassRoom.select(:id).each do |x| 
      ids.push(x.id)
    end
    return ClassRoom.where(:id => ids.sample).first
  end

end


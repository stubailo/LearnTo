class HomeController < ApplicationController

  def index
    @posts = []
    @announcements = []
    @resources = []
    
    #If there is a user logged in
  	if current_user
  		@user = current_user
  		@class_rooms = @user.class_rooms.sort_by { |class_room| class_room.updated_at }.reverse
      @news_feed_posts = []
  		@user.class_rooms.each do |classroom|
  		  @posts += classroom.forum.posts.order('created_at DESC').limit(10)
  		  @news_feed_posts += classroom.resources.limit(10).map do |resource|
          { :resource => resource,
            :type => "resource",
            :created_at => resource.created_at }
        end
  		  @news_feed_posts += classroom.announcements.order('created_at DESC').limit(6).map do |announcement|
          { :announcement => announcement,
            :type => "announcement",
            :created_at => announcement.created_at }
        end
  		end
  		@posts = @posts.sort_by! { |post| post.created_at}.reverse!.first(10)
  		@news_feed_posts = @news_feed_posts.sort_by { |post| post[:created_at]}.reverse!  
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
      @news_feed_posts = []
      @user.taught_classes.each do |classroom|
  		  @posts += classroom.forum.posts.order('created_at DESC').limit(10)
  		  @news_feed_posts += classroom.resources.limit(10).map do |resource|
          { :resource => resource,
            :type => "resource",
            :created_at => resource.created_at }
        end
  		  @news_feed_posts += classroom.announcements.order('created_at DESC').limit(6).map do |announcement|
          { :announcement => announcement,
            :type => "announcement",
            :created_at => announcement.created_at }
        end
      end
      @posts = @posts.sort_by! { |post| post.created_at}.reverse!.first(10)
  		@news_feed_posts = @news_feed_posts.sort_by { |post| post[:created_at]}.reverse!  
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


class HomeController < ApplicationController

  before_filter :store_location

  def index
    @posts = []
    @announcements = []
    @resources = []
    
  	if current_user
			if ClassRoom.exists?(1)	
				@class_room = ClassRoom.find(1)
				unless @class_room && @class_room.user.email == "jtwarren@mit.edu"
				  @class_room = nil
				end
			end	
			
  	  @ids = current_user.class_rooms.map { |x|  x.id }
  	  @news_feed_posts = []
  	  @posts = []
  	  if @ids.size > 0
    	  @news_feed_posts = Resource.where(:class_room_id => @ids).order('created_at DESC').where(:hidden => "false").limit(20).map do |resource|
            { :resource => resource,
              :type => "resource",
              :created_at => resource.created_at }
          end
        @news_feed_posts += Announcement.where(:class_room_id => @ids).order('created_at DESC').limit(20).map do |announcement|
            { :announcement => announcement,
              :type => "announcement",
              :created_at => announcement.created_at }
          end
    	  @posts = Post.where(:forum_id => @ids).order('created_at DESC').limit(10)
    		@news_feed_posts.sort_by! { |x| x[:created_at]}.reverse!.first(20)
      end
      @random_class_room = random
      render :action => "user_index", :layout => "layouts/user_home", :locals => {:which_tab => "user_index"}
    #There is no user logged in
    else
      @features = PremiumClass.first(4).sort_by { |x| x.created_at }.reverse
      render :action => "index"
      return
    end
  end        

  def teacher_index
    activity_by_user_and_class_id(1,1)
    @posts = []
    @announcements = []
    @resources = []
    
    if current_user
      @ids = current_user.taught_classes.map { |x|  x.id if x.active }
      @news_feed_posts = []
      @posts = []
      if @ids.size > 0
        @posts = Post.where(:forum_id => @ids).order('created_at DESC').limit(10)
      end
      @posts.sort_by! { |post| post.created_at}.reverse!.first(10)
  		@news_feed_posts.sort_by { |post| post[:created_at]}.reverse!  
      render :action => "teacher_index", :layout => "layouts/user_home", :locals => {:which_tab => "teacher_index"}
      @random_class_room = random
    else
      render :action => "index"
      return
    end
  end
  
  def manage
    @class_rooms = current_user.class_rooms
    @taught_classes = current_user.taught_classes
    render :action => "manage", :layout => "layouts/user_home", :locals => {:which_tab => "manage"}
  end

  def please_register
  
  end

  def media_test
  	if current_user
  		@user = current_user
  	end
  end
  
  def random
    @ids = []
    if current_user
      @cur_ids = current_user.class_rooms.map { |x|  x.id }
      @ids = ClassRoom.select(:id).where("id NOT IN (?)", @cur_ids).map { |x| x.id }
    else
      @ids = ClassRoom.select(:id).map { |x| x.id }
    end
    return ClassRoom.where(:id => @ids.sample).first
  end

end


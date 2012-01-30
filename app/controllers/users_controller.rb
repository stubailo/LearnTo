class UsersController < ApplicationController

  before_filter :store_location

  def show
    @user = User.find(params[:id])
    @is_me = @user == current_user
    @taught_classes = @user.taught_classes
    @class_rooms = @user.class_rooms
  end

  def new
    @user = User.new
  end
  
  def resend_activation
    if params[:email]
      @user = User.find_by_email params[:email]
      if @user && !@user.active?
        @user.deliver_activation_instructions!
        render 'home/please_register', :layout => "application"
      end
    end
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      @user.valid?
      if (verify_recaptcha(:model => @user, :message => "Captcha entered incorrectly")) && @user.save_without_session_maintenance
        @class_room = ClassRoom.find(1)
        if @class_room && Rails.env == "production" && @class_room.user.email == "jtwarren@mit.edu"
          user_permission = UserPermission.new(:user_id => @user.id, :class_room_id => @class_room.id, :permission_type => "student")
          user_permission.save
        end
        @user.update_attribute(:account_type, "internal")
        @user.deliver_activation_instructions!
        format.html { render 'home/please_register', :layout => "application" }
        format.xml { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @user = current_user
  end
  
  def edit_password
    @user = current_user
  end
  
  def update
    @user = current_user
    
    respond_to do |format|
      if params[:old_password]
        if @user.valid_password?(params[:old_password]) && @user.update_attributes(params[:user])
          format.html { redirect_to(user_path(@user), :notice => 'Credentials updated successfully.') }
          format.json { render :json => {}, :status => :ok }
        else
          flash[:fail] = "Old password entered incorrectly, please try again"
          format.html  { render :action => "edit_password" }
          format.json  { render :json => @user.errors, :status => :unprocessable_entity }
        end
      else
        if @user.update_attributes(params[:user])
          format.html { redirect_to(user_path(@user), :notice => 'Credentials updated successfully.') }
          format.json { render :json => {}, :status => :ok }
        else
          format.html  { render :action => "edit" }
          format.json  { render :json => @post.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    @user = current_user
    User.destroy(params[:id])

    flash[:notice] = "Successfully deleted and logged out."
    redirect_to root_url
  end
end

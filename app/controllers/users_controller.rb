class UsersController < ApplicationController

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
      if @user.update_attributes(params[:user])
        format.html { redirect_to(user_path(@user), :notice => 'Credentials updated successfully.') }
        format.json { render :json => {}, :status => :ok }
      else
        format.html  { render :action => "edit_password" }
        format.json  { render :json => @post.errors, :status => :unprocessable_entity }
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

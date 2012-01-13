class UsersController < ApplicationController

  def show
    @user = current_user
  end

  def new
	@user = User.new
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if (@user.valid? || verify_recaptcha(:model => @user, :message => "Captcha entered incorrectly")) && @user.save
        format.html { redirect_to user_url(@user), :notice => 'Registration successfull.' }
        format.xml { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit_password
	@user = current_user
  end
  
  def edit_email
	@user = current_user
  end
  
  def update
	@user = current_user
	
	respond_to do |format|
	  if @user.update_attributes(params[:user])
	    format.html	{ redirect_to(user_path(@user), :notice => 'Credentials updated successfully.') }
	    format.json { render :json => {}, :status => :ok }
	  else
	    format.html  { render :action => "edit" }
        format.json  { render :json => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
	@user_session = UserSession.find
    @user_session.destroy
    flash[:notice] = "Successfully deleted and logged out."
    redirect_to root_url
  end
end

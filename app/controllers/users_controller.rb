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
      if @user.save
        format.html { redirect_to user_url(@user), :notice => 'Registration successfull.' }
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

  def destroy
	@user_session = UserSession.find
    @user_session.destroy
    flash[:notice] = "Successfully deleted and logged out."
    redirect_to root_url
  end
end

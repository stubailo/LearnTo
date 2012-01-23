class AuthenticationsController < ApplicationController

  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    omniauth = request.env['omniauth.auth'] #this is where you get all the data from your provider through omniauth
    @auth = Authentication.find_from_hash(omniauth)
    if current_user
      flash[:notice] = "Successfully added #{omniauth['provider']} authentication"
      current_user.authentications.create(:provider => omniauth['provider'], :uid => omniauth['uid']) #Add an auth to existing user
      redirect_to root_path
    elsif @auth
      flash[:notice] = "Welcome back #{omniauth['provider']} user"
      UserSession.create(@auth.user, true) #User is present. Login the user with his social account
      redirect_to root_url
    else
      @new_auth = Authentication.create_from_hash(omniauth, current_user) #Create a new user
      flash[:notice] = "Welcome #{omniauth['provider']} user. Your account has been created."
      UserSession.create(@new_auth.user, true) #Log the authorizing user in.
      redirect_to root_url
    end
  end
 
  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end

end

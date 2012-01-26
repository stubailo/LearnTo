class AuthenticationsController < ApplicationController

  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    omniauth = request.env['omniauth.auth'] #this is where you get all the data from your provider through omniauth
    @auth = Authentication.find_from_hash(omniauth)
    if current_user
      user = current_user
      flash[:notice] = "Successfully added #{omniauth['provider']} authentication"
      user.authentications.find_or_create_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
      if user.account_type == "internal"
        user.update_attribute(:account_type, "both")
      end
      redirect_back_or_default root_path
    elsif @auth
      flash[:notice] = "Welcome back #{omniauth['provider']} user"
      UserSession.create(@auth.user, true) #User is present. Login the user with his social account
      redirect_back_or_default root_url
    else
      user = User.find_by_email(omniauth['info']['email'])
      if(user)
		    flash[:fail] = "Your facebook email is already tied to another account.  Recover that account and link your facebook through it."
	      redirect_to root_path
  	  else
  	    @new_auth = Authentication.create_from_hash(omniauth, current_user) #Create a new user
  	    flash[:notice] = "Welcome #{omniauth['provider']} user. Your account has been created."
    		UserSession.create(@new_auth.user, true) #Log the authorizing user in.
    		redirect_to root_url
  	  end
    end
  end
 
  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end

end

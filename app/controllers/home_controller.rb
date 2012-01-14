class HomeController < ApplicationController

  def index
	if current_user
		@user = current_user
	end
  end

  def media_test
	if current_user
		@user = current_user
	end
  end

end


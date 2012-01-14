class PagesController < ApplicationController
    def show
      # filter the params[:id] here to allow only certain values like
      if params[:id].match /test_media/
        render params[:id]
      else
        render :file => "/", :status => 404
      end
    end 
end

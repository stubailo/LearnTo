class PremiumClassesController < ApplicationController
  def show
    @class_room = ClassRoom.find(params[:class_room_id])
    @premium_class = PremiumClass.find(params[:id])
  end

  def new
    @class_room = ClassRoom.find(params[:class_room_id])
    @premium_class = PremiumClass.new
  end

  def create
    @premium_class = PremiumClass.new( params[:premium_class] )
    @premium_class.premium = Time.now
    @premium_class.class_room_id = params[:class_room_id]
    if @premium_class.save
      redirect_to class_room_premium_class_path(params[:class_room_id], @premium_class)
    else
      flash[:fail] = "Couldn't save premium content"
      redirect_to class_room_path(params[:class_room_id])
    end
    
  end

  def edit
    @class_room = ClassRoom.find(params[:class_room_id])
    @premium_class = PremiumClass.find(params[:id])
  end

  def update
    @class_room = ClassRoom.find(params[:class_room_id])
    @premium_class = PremiumClass.find(params[:id])
    if @premium_class.update_attributes(params[:premium_class])
      redirect_to :action => 'show'
    else
      flash[:fail] = "Couldn't save premium content"
      redirect_to class_room_path(params[:class_room_id])
    end
  end

  def destroy
    @premium_class = PremiumClass.find(params[:id])
    @premium_class.destroy
    redirect_to class_room_path(params[:class_room_id])
  end
end

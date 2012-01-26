class SectionsController < ApplicationController  
  
  def change_order
    #make sure we don't update updated_at when just changing order or publishing
    Section.record_timestamps = false
    
    @section = Section.find(params[:id])
    @resource_page = @section.resource_page
    @class_room = @resource_page.class_room
    new_order = params[:section][:order].to_i
    old_order = @section.order
    order_sections = @resource_page.sections.sort_by { |sec| sec.order }
    
    order_sections.delete_at(old_order)
    if new_order >= order_sections.length
      new_order = order_sections.length
    end
    order_sections.insert(new_order, @section)
    order_sections.each_with_index do |sec, i|
      sec.update_attribute(:order, i)
    end
    
    #Turn timestamps back on    
    Section.record_timestamps = true
    
    redirect_to class_room_resource_page_path(@class_room, @resource_page)
    
  end
  
  def create
  @section = Section.new(params[:section])
  class_room = ClassRoom.find(params[:class_room_id])
    if is_creator(class_room)
      resource_page = ResourcePage.find(params[:resource_page_id])
      sections = class_room.sections.sort_by { |sec| sec.order }
      @section.order = sections.last.order + 1
      @section.resource_page_id = params[:resource_page_id]
      if(@section.save)
        redirect_to class_room_resource_page_path(class_room, resource_page)
      else
        redirect_to class_room_resource_page_path(class_room, resource_page)
      end
    else
      redirect_back_or_default class_room_resource_page_path(class_room, resource_page), :flash => { :fail => "You must be the creator of the class to do that." }
    end
  end
  
  def update
    @section = Section.find(params[:id])
    @class_room = ClassRoom.find(params[:class_room_id])
    @resource_page = ResourcePage.find(params[:resource_page_id])
    if is_creator(@class_room)
      if @section.update_attributes(params[:section])
        redirect_back_or_default class_room_resource_page_path(class_room, resource_page)
      else
        redirect_back_or_default class_room_resource_page_path(class_room, resource_page), :flash => { :fail => "Error updating section" }
      end
    else
      redirect_back_or_default class_room_resource_page_path(class_room, resource_page), :flash => { :fail => "You must be the creator of the class to do that." }
    end
  end
  
  def destroy
    @section = Section.find(params[:id])
    @resources = @section.resources
    resource_page = ResourcePage.find(params[:resource_page_id])
    class_room = ClassRoom.find(params[:class_room_id])
    if resource_page.sections.length > 1
      if is_creator(class_room)
        @section.destroy
      end
    end

    respond_to do |format|
      format.html { redirect_to class_room_resource_page_path(class_room, resource_page) }
      format.json { head :no_content }
    end
  end

end

require 'test_helper'

class ClassRoomsControllerTest < ActionController::TestCase
  setup do
    @class_room = class_rooms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:class_rooms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create class_room" do
    assert_difference('ClassRoom.count') do
      post :create, class_room: @class_room.attributes
    end

    assert_redirected_to class_room_path(assigns(:class_room))
  end

  test "should show class_room" do
    get :show, id: @class_room
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @class_room
    assert_response :success
  end

  test "should update class_room" do
    put :update, id: @class_room, class_room: @class_room.attributes
    assert_redirected_to class_room_path(assigns(:class_room))
  end

  test "should destroy class_room" do
    assert_difference('ClassRoom.count', -1) do
      delete :destroy, id: @class_room
    end

    assert_redirected_to class_rooms_path
  end
end

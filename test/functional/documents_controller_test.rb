require 'test_helper'

class DocumentsControllerTest < ActionController::TestCase
  test "should get create_doc_rec" do
    get :create_doc_rec
    assert_response :success
  end

end

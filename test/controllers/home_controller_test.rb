require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get top" do
    get :top
    assert_response :success
  end

  test "should get tfdiary" do
    get :tfdiary
    assert_response :success
  end

  test "should get login_form" do
    get :login_form
    assert_response :success
  end

end

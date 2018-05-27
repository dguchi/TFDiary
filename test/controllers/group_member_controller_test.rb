require 'test_helper'

class GroupMemberControllerTest < ActionController::TestCase
  test "should get top" do
    get :top
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get menu_confirm" do
    get :menu_confirm
    assert_response :success
  end

  test "should get setting" do
    get :setting
    assert_response :success
  end

end

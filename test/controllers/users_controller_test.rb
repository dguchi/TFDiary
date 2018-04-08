require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get follow-index" do
    get :follow-index
    assert_response :success
  end

  test "should get menu-index" do
    get :menu-index
    assert_response :success
  end

  test "should get group-index" do
    get :group-index
    assert_response :success
  end

end

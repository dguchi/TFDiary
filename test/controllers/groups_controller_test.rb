require 'test_helper'

class GroupsControllerTest < ActionController::TestCase
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

  test "should get member-top" do
    get :member-top
    assert_response :success
  end

  test "should get member-index" do
    get :member-index
    assert_response :success
  end

  test "should get menu-confirm" do
    get :menu-confirm
    assert_response :success
  end

  test "should get setting" do
    get :setting
    assert_response :success
  end

end

require 'test_helper'

class ChangelistsControllerTest < ActionController::TestCase
  setup do
    @changelist = changelists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:changelists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create changelist" do
    assert_difference('Changelist.count') do
      post :create, changelist: @changelist.attributes
    end

    assert_redirected_to changelist_path(assigns(:changelist))
  end

  test "should show changelist" do
    get :show, id: @changelist.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @changelist.to_param
    assert_response :success
  end

  test "should update changelist" do
    put :update, id: @changelist.to_param, changelist: @changelist.attributes
    assert_redirected_to changelist_path(assigns(:changelist))
  end

  test "should destroy changelist" do
    assert_difference('Changelist.count', -1) do
      delete :destroy, id: @changelist.to_param
    end

    assert_redirected_to changelists_path
  end
end

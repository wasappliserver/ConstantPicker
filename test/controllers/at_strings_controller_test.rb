require 'test_helper'

class AtStringsControllerTest < ActionController::TestCase
  setup do
    @at_string = at_strings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:at_strings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create at_string" do
    assert_difference('AtString.count') do
      post :create, at_string: { title: @at_string.title, value: @at_string.value }
    end

    assert_redirected_to at_string_path(assigns(:at_string))
  end

  test "should show at_string" do
    get :show, id: @at_string
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @at_string
    assert_response :success
  end

  test "should update at_string" do
    patch :update, id: @at_string, at_string: { title: @at_string.title, value: @at_string.value }
    assert_redirected_to at_string_path(assigns(:at_string))
  end

  test "should destroy at_string" do
    assert_difference('AtString.count', -1) do
      delete :destroy, id: @at_string
    end

    assert_redirected_to at_strings_path
  end
end

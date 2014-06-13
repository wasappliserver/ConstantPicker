require 'test_helper'

class ThemeColorsControllerTest < ActionController::TestCase
  setup do
    @theme_color = theme_colors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:theme_colors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create theme_color" do
    assert_difference('ThemeColor.count') do
      post :create, theme_color: { app_id=integer: @theme_color.app_id=integer, color=string: @theme_color.color=string }
    end

    assert_redirected_to theme_color_path(assigns(:theme_color))
  end

  test "should show theme_color" do
    get :show, id: @theme_color
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @theme_color
    assert_response :success
  end

  test "should update theme_color" do
    patch :update, id: @theme_color, theme_color: { app_id=integer: @theme_color.app_id=integer, color=string: @theme_color.color=string }
    assert_redirected_to theme_color_path(assigns(:theme_color))
  end

  test "should destroy theme_color" do
    assert_difference('ThemeColor.count', -1) do
      delete :destroy, id: @theme_color
    end

    assert_redirected_to theme_colors_path
  end
end

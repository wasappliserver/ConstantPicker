require 'test_helper'

class LocalizablesControllerTest < ActionController::TestCase
  setup do
    @localizable = localizables(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:localizables)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create localizable" do
    assert_difference('Localizable.count') do
      post :create, localizable: { app_id: @localizable.app_id, key: @localizable.key, lang: @localizable.lang, missing: @localizable.missing, value: @localizable.value }
    end

    assert_redirected_to localizable_path(assigns(:localizable))
  end

  test "should show localizable" do
    get :show, id: @localizable
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @localizable
    assert_response :success
  end

  test "should update localizable" do
    patch :update, id: @localizable, localizable: { app_id: @localizable.app_id, key: @localizable.key, lang: @localizable.lang, missing: @localizable.missing, value: @localizable.value }
    assert_redirected_to localizable_path(assigns(:localizable))
  end

  test "should destroy localizable" do
    assert_difference('Localizable.count', -1) do
      delete :destroy, id: @localizable
    end

    assert_redirected_to localizables_path
  end
end

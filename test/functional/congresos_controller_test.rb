require 'test_helper'

class CongresosControllerTest < ActionController::TestCase
  setup do
    @congreso = congresos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:congresos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create congreso" do
    assert_difference('Congreso.count') do
      post :create, congreso: @congreso.attributes
    end

    assert_redirected_to congreso_path(assigns(:congreso))
  end

  test "should show congreso" do
    get :show, id: @congreso.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @congreso.to_param
    assert_response :success
  end

  test "should update congreso" do
    put :update, id: @congreso.to_param, congreso: @congreso.attributes
    assert_redirected_to congreso_path(assigns(:congreso))
  end

  test "should destroy congreso" do
    assert_difference('Congreso.count', -1) do
      delete :destroy, id: @congreso.to_param
    end

    assert_redirected_to congresos_path
  end
end

require 'test_helper'

class GradoEstudiosControllerTest < ActionController::TestCase
  setup do
    @grado_estudio = grado_estudios(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:grado_estudios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create grado_estudio" do
    assert_difference('GradoEstudio.count') do
      post :create, grado_estudio: @grado_estudio.attributes
    end

    assert_redirected_to grado_estudio_path(assigns(:grado_estudio))
  end

  test "should show grado_estudio" do
    get :show, id: @grado_estudio.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @grado_estudio.to_param
    assert_response :success
  end

  test "should update grado_estudio" do
    put :update, id: @grado_estudio.to_param, grado_estudio: @grado_estudio.attributes
    assert_redirected_to grado_estudio_path(assigns(:grado_estudio))
  end

  test "should destroy grado_estudio" do
    assert_difference('GradoEstudio.count', -1) do
      delete :destroy, id: @grado_estudio.to_param
    end

    assert_redirected_to grado_estudios_path
  end
end

require 'test_helper'

class HonorarioMinimosControllerTest < ActionController::TestCase
  setup do
    @honorario_minimo = honorario_minimos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:honorario_minimos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create honorario_minimo" do
    assert_difference('HonorarioMinimo.count') do
      post :create, honorario_minimo: { concepto: @honorario_minimo.concepto, create_by: @honorario_minimo.create_by, desde: @honorario_minimo.desde, hasta: @honorario_minimo.hasta, porcentaje: @honorario_minimo.porcentaje }
    end

    assert_redirected_to honorario_minimo_path(assigns(:honorario_minimo))
  end

  test "should show honorario_minimo" do
    get :show, id: @honorario_minimo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @honorario_minimo
    assert_response :success
  end

  test "should update honorario_minimo" do
    patch :update, id: @honorario_minimo, honorario_minimo: { concepto: @honorario_minimo.concepto, create_by: @honorario_minimo.create_by, desde: @honorario_minimo.desde, hasta: @honorario_minimo.hasta, porcentaje: @honorario_minimo.porcentaje }
    assert_redirected_to honorario_minimo_path(assigns(:honorario_minimo))
  end

  test "should destroy honorario_minimo" do
    assert_difference('HonorarioMinimo.count', -1) do
      delete :destroy, id: @honorario_minimo
    end

    assert_redirected_to honorario_minimos_path
  end
end

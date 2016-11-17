require 'test_helper'

class VisadosControllerTest < ActionController::TestCase
  setup do
    @visado = visados(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:visados)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create visado" do
    assert_difference('Visado.count') do
      post :create, visado: {  }
    end

    assert_redirected_to visado_path(assigns(:visado))
  end

  test "should show visado" do
    get :show, id: @visado
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @visado
    assert_response :success
  end

  test "should update visado" do
    patch :update, id: @visado, visado: {  }
    assert_redirected_to visado_path(assigns(:visado))
  end

  test "should destroy visado" do
    assert_difference('Visado.count', -1) do
      delete :destroy, id: @visado
    end

    assert_redirected_to visados_path
  end
end

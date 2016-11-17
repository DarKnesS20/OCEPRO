require 'test_helper'

class IndiceCostosUsoCatsControllerTest < ActionController::TestCase
  setup do
    @indice_costos_uso_cat = indice_costos_uso_cats(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:indice_costos_uso_cats)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create indice_costos_uso_cat" do
    assert_difference('IndiceCostosUsoCat.count') do
      post :create, indice_costos_uso_cat: {  }
    end

    assert_redirected_to indice_costos_uso_cat_path(assigns(:indice_costos_uso_cat))
  end

  test "should show indice_costos_uso_cat" do
    get :show, id: @indice_costos_uso_cat
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @indice_costos_uso_cat
    assert_response :success
  end

  test "should update indice_costos_uso_cat" do
    patch :update, id: @indice_costos_uso_cat, indice_costos_uso_cat: {  }
    assert_redirected_to indice_costos_uso_cat_path(assigns(:indice_costos_uso_cat))
  end

  test "should destroy indice_costos_uso_cat" do
    assert_difference('IndiceCostosUsoCat.count', -1) do
      delete :destroy, id: @indice_costos_uso_cat
    end

    assert_redirected_to indice_costos_uso_cats_path
  end
end

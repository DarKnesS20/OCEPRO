require 'test_helper'

class CostosCivsControllerTest < ActionController::TestCase
  setup do
    @costos_civ = costos_civs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:costos_civs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create costos_civ" do
    assert_difference('CostosCiv.count') do
      post :create, costos_civ: { civ: @costos_civ.civ, created_by_id: @costos_civ.created_by_id }
    end

    assert_redirected_to costos_civ_path(assigns(:costos_civ))
  end

  test "should show costos_civ" do
    get :show, id: @costos_civ
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @costos_civ
    assert_response :success
  end

  test "should update costos_civ" do
    patch :update, id: @costos_civ, costos_civ: { civ: @costos_civ.civ, created_by_id: @costos_civ.created_by_id }
    assert_redirected_to costos_civ_path(assigns(:costos_civ))
  end

  test "should destroy costos_civ" do
    assert_difference('CostosCiv.count', -1) do
      delete :destroy, id: @costos_civ
    end

    assert_redirected_to costos_civs_path
  end
end

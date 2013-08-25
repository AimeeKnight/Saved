require 'test_helper'

class TestimoniesControllerTest < ActionController::TestCase
  setup do
    @testimony = testimonies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:testimonies)
  end

  test "should be redirected when not logged in" do
    get :new
    assert_response :redirect 
    assert_redirected_to new_user_session_path
  end

  test "should render the new page when logged in" do
    sign_in users(:aimee)
    get :new
    assert_response :success
  end

  test "should be logged in to post a testimony" do
    post :create, testimony: { content: "Hello" }
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should create testimony when logged in" do
    sign_in users(:aimee)
    assert_difference('Testimony.count') do
      post :create, testimony: { content: @testimony.content }
    end

    assert_redirected_to testimony_path(assigns(:testimony))
  end

  test "should show testimony" do
    get :show, id: @testimony
    assert_response :success
  end

  test "should get edit when logged in" do
    sign_in users(:aimee)
    get :edit, id: @testimony
    assert_response :success
  end

  test "should redirect testimony update when not logged in" do
    put :update, id: @testimony, testimony: { content: @testimony.content }
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should update testimony when logged in" do
    sign_in users(:aimee)
    put :update, id: @testimony, testimony: { content: @testimony.content }
    assert_redirected_to testimony_path(assigns(:testimony))
  end

  test "should destroy testimony" do
    assert_difference('Testimony.count', -1) do
      delete :destroy, id: @testimony
    end

    assert_redirected_to testimonies_path
  end
end

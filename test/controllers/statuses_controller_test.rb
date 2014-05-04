require 'test_helper'

class StatusesControllerTest < ActionController::TestCase
  setup do
    @status = statuses(:test_status1)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:statuses)
  end

  test "should be redirected away from new when not logged in" do
    get :new
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should render the new page when logged in" do
    sign_in users(:test_user)
    get :new
    assert_response :success
  end

  test "should be logged in to post a status" do
    post :create, status: { content: @status.content, user_id: @status.user_id }
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should render the status page when logged in" do
    sign_in users(:test_user)
    post :create, status: { content: @status.content, user_id: @status.user_id }
    assert_response :redirect
    assert_redirected_to status_path(assigns(:status))
  end

  test "should create status when logged in" do
    sign_in users(:test_user)

    assert_difference('Status.count') do
      post :create, status: { content: @status.content }
    end

    assert_redirected_to status_path(assigns(:status))
  end

  test "should create status for the current user when logged in" do
    sign_in users(:test_user)

    assert_difference('Status.count') do
      post :create, status: { content: @status.content, user_id: users(:test_user2).id }
    end

    assert_redirected_to status_path(assigns(:status))
    assert_equal assigns(:status).user_id, users(:test_user).id
  end

  test "should show status" do
    get :show, id: @status
    assert_response :success
  end

  test "should get redirected from edit when not logged in" do
    get :edit, id: @status
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should get edit when logged in" do
    sign_in users(:test_user)
    get :edit, id: @status
    assert_response :success
  end

  test "should get redirected from update when not logged in" do
    patch :update, id: @status, status: { content: @status.content, user_id: @status.user_id }
    assert_redirected_to new_user_session_path
  end

  test "should update status when logged in" do
    sign_in users(:test_user)
    patch :update, id: @status, status: { content: @status.content }
    assert_redirected_to status_path(assigns(:status))
  end

  test "should update status only for current logged in user" do
    sign_in users(:test_user)
    patch :update, id: @status, status: { content: @status.content, user_id: users(:test_user2).id }
    assert_redirected_to status_path(assigns(:status))
    assert_equal assigns(:status).user_id, users(:test_user).id
  end

  test "should not update status if nothing has changed" do
    sign_in users(:test_user)
    patch :update, id: @status, status: { content: @status.content, user_id: users(:test_user).id }
    assert_redirected_to status_path(assigns(:status))
    assert_equal assigns(:status).user_id, users(:test_user).id
  end

  test "should destroy status" do
    assert_difference('Status.count', -1) do
      delete :destroy, id: @status
    end

    assert_redirected_to statuses_path
  end
end

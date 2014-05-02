require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  test "should get show" do
    get :show, id: users(:test_user).profile_name
    assert_response :success
    assert_template 'profiles/show'
  end

  test "show render a 404 if profile not found" do
  	get :show, id: "Doesn't exist"
  	assert_response :not_found
  end

  test "that the controller sets the @user and @statuses instance variable, and that @statuses is not empty" do
  	get :show, id: users(:test_user).profile_name
  	assert assigns(:user)
  	assert_not_empty assigns(:statuses)
  end

  test "only shows the correct user's statuses" do
  	get :show, id: users(:test_user).profile_name
  	assigns(:statuses).each do |status|
  		assert_equal users(:test_user), status.user
  	end
  end
end

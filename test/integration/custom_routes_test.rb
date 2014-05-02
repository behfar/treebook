require 'test_helper'

class CustomRoutesTest < ActionDispatch::IntegrationTest
	test "that /login route results in :success" do
		get '/login'
		assert_response :success
	end

	test "that /logout route results in :redirect" do
		delete '/logout'
		assert_response :redirect
		assert_redirected_to '/'
	end

	test "that /register route results in :success" do
		get '/register'
		assert_response :success
	end

	test "that a profile page works" do
		get '/JD'
		assert_response :success
	end
end

require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "a user should enter a first name" do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:first_name].empty?
  end

  test "a user should enter a last name" do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:last_name].empty?
  end

  test "a user should enter an email" do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:email].empty?
  end

  test "a user should enter a unique email" do
  	user = User.new
  	user.email = users(:test_user).email

  	assert !user.save
  	assert !user.errors[:email].empty?
  end

  test "a user should enter a profile name" do
  	user = User.new(first_name: "John", last_name: "Doe", email: "john@doe.com")
  	assert !user.save
  	assert !user.errors[:profile_name].empty?
  end

  test "a user should enter a unique profile name" do
  	user = User.new(first_name: "John", last_name: "Doe", email: "john@doe.com")
  	user.profile_name = users(:test_user).profile_name

  	assert !user.save
  	assert !user.errors[:profile_name].empty?
  end

  test "a user should enter a profile name without spaces" do
  	user = User.new(first_name: "John", last_name: "Doe", email: "john@doe.com", profile_name: "Test profile name with spaces")

  	assert !user.save
  	assert !user.errors[:profile_name].empty?
  	assert user.errors[:profile_name].include?("Must be formatted correctly.")
  end

end

require 'test_helper'

class UserFriendshipTest < ActiveSupport::TestCase
	should belong_to(:user)
	should belong_to(:friend)

	test "that creating a friendship works without raising an exception"  do
		assert_nothing_raised do
			UserFriendship.create user: users(:aimee), friend: users(:jamie)
		end
	end

	test "that creating a friendship bases on user id and friend id works" do
		UserFriendship.create user_id: users(:aimee).id, friend_id: users(:jamie).id
  	assert users(:aimee).friends.include?(users(:jamie))
	end
end

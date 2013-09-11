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
  	assert users(:aimee).pending_friends.include?(users(:jamie))
	end

	context "a new instance" do
		setup	do
			@user_friendship = UserFriendship.new user: users(:aimee), friend: users(:jamie)
		end

		should "have a pending state" do
			assert_equal 'pending', @user_friendship.state
		end
	end

	context "#send_request_email" do
		setup do
			@user_friendship = UserFriendship.create user: users(:aimee), friend: users(:jamie)
		end

		should "send an email" do
			assert_difference 'ActionMailer::Base.deliveries.size', 1 do
				@user_friendship.send_request_email
			end
		end
	end

	context	"#accept!" do
		setup do
			@user_friendship = UserFriendship.create user: users(:aimee), friend: users(:jamie)
		end

		should	"set the state to accepted" do
			@user_friendship.accept!
			assert_equal	"accepted", @user_friendship.state
		end

		should "send an acceptance email" do
			assert_difference 'ActionMailer::Base.deliveries.size', 1 do
				@user_friendship.accept!
			end
		end

		should "include the friend in the list of friends" do
			@user_friendship.accept!
			users(:aimee).friends.reload
			assert users(:aimee).friends.include?(users(:jamie))
		end
	end

	context ".request" do
		should "create two user friendships" do
			assert_difference 'UserFriendship.count', 2 do
				UserFriendship.request(users(:aimee), users(:jamie))
			end
		end

		should "send a friend request email" do
			assert_difference 'ActionMailer::Base.deliveries.size', 1 do
				UserFriendship.request(users(:aimee), users(:jamie))
			end
		end
	end
end

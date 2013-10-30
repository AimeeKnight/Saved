class UserFriendshipsController < ApplicationController
	before_filter :authenticate_user!

	def index
		@user_friendships = current_user.user_friendships.all
	end

	def accept
		@user_friendship = current_user.user_friendships.find(params[:id])
		if @user_friendship.accept!
			flash[:success] = "You are now friends with #{@user_friendship.friend.first_name}"
		else
			flash[:error] = "That friendship cound not be accepted"
		end
		redirect_to user_friendships_path
	end

	def new
		#friend_id is profile name
		if params[:friend_id]
			@friend = User.where(profile_name: params[:friend_id]).first

			raise ActiveRecord::RecordNotFound if @friend.nil?
			@user_friendship = current_user.user_friendships.new(friend: @friend)
		else
			flash[:error] = "Friend required"
		end

	#if friend_id can't be found	
	rescue ActiveRecord::RecordNotFound
		render file: 'public/404', status: :not_found
	end

	def create
		if params[:user_friendship] && params[:user_friendship].has_key?(:friend_id)
			@friend = User.where(profile_name: params[:user_friendship][:friend_id]).first
			@user_friendship = UserFriendship.request(current_user, @friend)
			if @user_friendship.new_record?
				flash[:error] = "There was a problem creating this friendship."
			else
				flash[:success] = "Friend request sent."
			end
			redirect_to profile_path(@friend)
		else
			flash[:error] = "Friend required"
			redirect_to root_path
		end
	end

	def edit
		@user_friendship = current_user.user_friendships.find(params[:id])
		@friend = @user_friendship.friend
	end

	def destroy	
		@user_friendship = current_user.user_friendships.find(params[:id])
		if @user_friendship.destroy
			flash[:sucess] = "Friendship destroyed"
		end
		redirect_to user_friendships_path
	end
end

require 'test_helper'

class TestimonyTest < ActiveSupport::TestCase
	test "that a testimony requires the content to be entered" do
		testimony = Testimony.new
		assert !testimony.save
		assert !testimony.errors[:content].empty?		
	end

	test "that testimony's content is at least 2 letters" do
		testimony = Testimony.new
		testimony.content = "H"
		assert !testimony.save
		assert !testimony.errors[:content].empty?				
	end

	test "that a testimony has a user id" do
		testimony = Testimony.new
		testimony.content = "Saved"
		assert !testimony.save
		assert !testimony.errors[:user_id].empty?
	end
end

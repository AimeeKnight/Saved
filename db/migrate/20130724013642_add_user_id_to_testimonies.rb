class AddUserIdToTestimonies < ActiveRecord::Migration
  def change
  	add_column :testimonies, :user_id, :integer
  	add_index :testimonies, :user_id
  	remove_column :testimonies, :name
  end
end

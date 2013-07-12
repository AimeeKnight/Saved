class CreateTestimonies < ActiveRecord::Migration
  def change
    create_table :testimonies do |t|
      t.string :name
      t.text :content

      t.timestamps
    end
  end
end

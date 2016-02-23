class AddUserIdToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :user_id, :integer, null: false
    add_index  :courses, :user_id
  end
end

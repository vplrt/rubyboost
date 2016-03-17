class AddExpelledToCourseUsers < ActiveRecord::Migration
  def change
    add_column :course_users, :expelled, :boolean, default: false, null: false, index: true
  end
end

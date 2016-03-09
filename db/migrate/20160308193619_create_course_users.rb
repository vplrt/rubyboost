class CreateCourseUsers < ActiveRecord::Migration
  def change
    create_table :course_users do |t|
      t.integer :user_id
      t.integer :course_id

      t.timestamps null: false
    end

    add_index :course_users, [:user_id, :course_id], unique: true
  end
end

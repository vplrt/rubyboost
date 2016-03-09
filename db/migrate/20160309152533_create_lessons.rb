class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :title
      t.integer :position
      t.text :description
      t.string :picture
      t.text :notes
      t.text :homework
      t.integer :user_id
      t.integer :course_id

      t.timestamps null: false
    end

    add_index :lessons, :user_id
    add_index :lessons, :course_id
    add_index :lessons, :position
  end
end

class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :title
      t.boolean :active, :boolean, default: true, null: false, index: true

      t.timestamps null: false
    end
  end
end

class RenameActiveCourseToVisibleCourse < ActiveRecord::Migration
  def change
    rename_column :courses, :active, :visible
  end
end

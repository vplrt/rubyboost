class AddDateToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :date, :datetime, null: false
  end
end

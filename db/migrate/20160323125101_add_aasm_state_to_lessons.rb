class AddAasmStateToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :state, :string
    add_index  :lessons, :state
  end
end

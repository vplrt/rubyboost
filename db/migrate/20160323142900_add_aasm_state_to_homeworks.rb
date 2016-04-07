class AddAasmStateToHomeworks < ActiveRecord::Migration
  def change
    add_column :homeworks, :state, :string
    add_index  :homeworks, :state
  end
end

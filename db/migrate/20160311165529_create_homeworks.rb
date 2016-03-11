class CreateHomeworks < ActiveRecord::Migration
  def change
    create_table :homeworks do |t|
      t.integer :user_id
      t.integer :lesson_id
      t.text :body

      t.timestamps null: false
    end

    add_index :homeworks, :user_id
    add_index :homeworks, :lesson_id
    add_index :homeworks, [:user_id, :lesson_id], unique: true
  end
end

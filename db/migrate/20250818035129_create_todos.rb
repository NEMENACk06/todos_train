class CreateTodos < ActiveRecord::Migration[8.0]
  def change
    create_table :todos do |t|
      t.references :category, null: false, foreign_key: true

      t.string  :title,   null: false
      t.text    :notes
      t.boolean :is_done, null: false, default: false

      # priority_level (Eisenhower matrix 4 ค่า)
      # 0 = not_important_not_urgent
      # 1 = important_not_urgent
      # 2 = not_important_urgent
      # 3 = important_urgent
      t.integer :priority_level, null: false, default: 0

      t.date :due_on
      t.time :due_time
      t.integer :position, null: false, default: 0

      t.timestamps
    end

    add_index :todos, :is_done
    add_index :todos, :priority_level
    add_index :todos, [ :category_id, :position ]
  end
end

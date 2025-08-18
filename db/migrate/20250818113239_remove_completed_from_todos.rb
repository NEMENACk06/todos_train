class RemoveCompletedFromTodos < ActiveRecord::Migration[8.0]
  def up
    remove_column :todos, :completed, :boolean
  end

  def down
    add_column :todos, :completed, :boolean, default: false, null: false
    execute "UPDATE todos SET completed = is_done"
  end
end

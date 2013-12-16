class AddDueDateToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :due_date, :timestamp
  end
end

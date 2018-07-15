class AddColumnsToTodo < ActiveRecord::Migration
  def change
    add_column :todos, :name, :text
    add_column :todos, :completed, :boolean
  end
end

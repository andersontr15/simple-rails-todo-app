class TodosController < ApplicationController
  def index 
    render json: todo_blueprint(todos)
  end 

  def todos 
    Todo.all 
  end 

  def new 
  end 

  def completed
    todos = Todo.where(completed: true)
    render json: {
      todos: todo_blueprint(todos),
      status: 'Completed todos'
    }
  end 

  def remaining 
    todos = Todo.where(completed: false)
    render json: {
      todos: todo_blueprint(todos).as_json,
      type: 'Uncompleted todos'
    }
  end 

  def show 
    todo = todos.find_by_id(params[:id])
    if todo
      render json: todo_blueprint(todo)
    else 
      render json: { message: "No todo found with this id", status: 404, todo: todo }, status: :not_found
    end 
  end 

  def create 
    todo = Todo.new(create_todo_params)
    if todo.save
      redirect_to :root
    else 
      render json: { message: "Failed to save todo", status: 400 }
    end 
  end 

  def edit 
    @todo = Todo.find_by_id(params[:id])
    if @todo.nil? 
      render json: { message: "Trying to edit a todo that doesn't exists", status: 400}, status: :not_found
    end 
  end 

  def update 
    todo = Todo.find(params[:id])
      todo.update(update_todo_params)
      redirect_to :root
  end 

  private 

  def create_todo_params 
    params.require(:todo).permit(
      :name,
      :completed
    )
  end 

  def update_todo_params 
    params.require(:todo).permit(
      :name,
      :completed
    )
  end 
  
  def todo_blueprint(todos)
    TodoBlueprint.render(todos)
  end 
end

class Api::TodosController < ApplicationController
  def index
    render json: Todo.order(id: :desc)
  end

  def create
    todo = Todo.create todo_params
    render json: todo
  end

  def update
    Todo.find(params[:id].to_i).update todo_params
    render nothing: true
  end

  def destroy
    Todo.find(params[:id]).destroy
    render nothing: true
  end

  private
  def todo_params
    params.require(:todo).permit(:id, :name, :done, :due_date)
  end
end

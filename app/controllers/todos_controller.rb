# app/controllers/todos_controller.rb
class TodosController < ApplicationController
  before_action :set_category

  def create
    @todo = @category.todos.new(todo_params)
    if @todo.save
      redirect_to categories_path, notice: "Todo added."
    else
      redirect_to categories_path, alert: "Failed to add todo."
    end
  end

  def update
    @todo = @category.todos.find(params[:id])
    @todo.update(todo_params)
    redirect_to categories_path
  end

  def destroy
    @todo = @category.todos.find(params[:id])
    @todo.destroy
    redirect_to categories_path, notice: "Todo deleted."
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end

  def todo_params
    params.require(:todo).permit(:title, :notes, :is_done, :priority_level)
  end
end

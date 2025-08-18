# app/controllers/todos_controller.rb
class TodosController < ApplicationController
  before_action :set_category
  before_action :set_todo, only: [ :update, :destroy, :toggle ]

  def create
    @todo = @category.todos.new(todo_params)
    if @todo.save
      respond_to do |f|
        f.turbo_stream   # << สำคัญ
        f.html { redirect_to categories_path, notice: "Todo created" }
      end
    else
      respond_to do |f|
        f.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            helpers.dom_id(@category, :new_todo_form),
            partial: "todos/form",
            locals: { category: @category, todo: @todo }
          )
        end
        f.html { redirect_to categories_path, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @todo.update(todo_params)
      respond_to { |f| f.turbo_stream; f.html { redirect_to categories_path } }
    else
      respond_to { |f| f.turbo_stream; f.html { redirect_to categories_path } }
    end
  end

  def toggle
    @todo.update!(is_done: !@todo.is_done)
    respond_to do |f|
      f.turbo_stream { render :update } # จะไปใช้ update.turbo_stream.erb
      f.html { redirect_to categories_path }
    end
  end

  def destroy
    @todo.destroy
    respond_to { |f| f.turbo_stream; f.html { redirect_to categories_path } }
  end

  private
  def set_category; @category = Category.find(params[:category_id]); end
  def set_todo;     @todo = @category.todos.find(params[:id]); end
  def todo_params
    params.require(:todo).permit(:title, :notes, :priority_level, :due_on, :due_time, :position, :is_done)
  end
end

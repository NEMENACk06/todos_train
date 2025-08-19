module CategoriesHelper
  def category_name_with_count(category)
    "#{category.name} (#{category.todos.where(is_done: true).count}/#{category.todos.count})"
  end
end

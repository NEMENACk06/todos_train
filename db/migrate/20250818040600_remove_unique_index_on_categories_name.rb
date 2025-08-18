class RemoveUniqueIndexOnCategoriesName < ActiveRecord::Migration[8.0]
  def change
    remove_index :categories, :name
    add_index :categories, :name   # index ธรรมดา ไม่ unique
  end
end

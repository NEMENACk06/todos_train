class CreateCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :categories do |t|
      t.string  :name,     null: false
      t.string  :color
      t.integer :position, null: false, default: 0

      t.timestamps
    end

    add_index :categories, :name, unique: true
    add_index :categories, :position
  end
end

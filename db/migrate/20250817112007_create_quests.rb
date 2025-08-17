class CreateQuests < ActiveRecord::Migration[8.0]
  def change
    create_table :quests do |t|
      t.string :name
      t.boolean :is_done, default: false, null: false

      t.timestamps
    end
  end
end

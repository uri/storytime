class CreateStoryCards < ActiveRecord::Migration
  def change
    create_table :story_cards do |t|
      t.string :content
      t.integer :parent_id
      t.integer :user_id
      t.timestamps
    end
  end
end

class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.boolean :value
      t.integer :user_id
      t.integer :story_card_id

      t.timestamps
    end
  end
end

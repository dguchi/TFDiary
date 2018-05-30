class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.text :content
      t.integer :user_id
      t.integer :group_id

      t.timestamps null: false
    end
  end
end

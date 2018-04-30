class CreateDiaries < ActiveRecord::Migration
  def change
    create_table :diaries do |t|
      t.date :date
      t.text :explain
      t.integer :user_id

      t.timestamps null: false
    end
  end
end

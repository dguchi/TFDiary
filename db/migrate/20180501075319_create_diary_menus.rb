class CreateDiaryMenus < ActiveRecord::Migration
  def change
    create_table :diary_menus do |t|
      t.integer :diary_id
      t.integer :menu_id
      t.integer :set
      t.integer :num
      t.integer :rest_min, default: 0
      t.integer :rest_sec, default: 0

      t.timestamps null: false
    end
  end
end

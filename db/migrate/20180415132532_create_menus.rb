class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :name
      t.integer :kind, default: 0, null: false, limit: 1
      t.text :explain
      t.integer :author_id
      t.boolean :secret, default: false

      t.timestamps null: false
    end
  end
end

class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :mail
      t.integer :main_group_id
      t.string :image
      t.string :password_digest

      t.timestamps null: false
    end
  end
end

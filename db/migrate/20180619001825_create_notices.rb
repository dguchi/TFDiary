class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.text :msg
      t.string :link
      t.integer :user_id

      t.timestamps null: false
    end
  end
end

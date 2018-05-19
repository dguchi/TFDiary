class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.text :explain
      t.text :target
      t.string :image
      t.integer :leader_id
      t.integer :manager_id1
      t.integer :manager_id2
      t.integer :subleader_id1
      t.integer :subleader_id2
      t.integer :subleader_id3

      t.timestamps null: false
    end
  end
end

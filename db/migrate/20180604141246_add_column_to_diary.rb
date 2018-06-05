class AddColumnToDiary < ActiveRecord::Migration
  def change
    add_column :diaries, :group_id, :integer
  end
end

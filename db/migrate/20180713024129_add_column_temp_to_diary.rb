class AddColumnTempToDiary < ActiveRecord::Migration
  def change
    add_column :diaries, :temp, :boolean, default: false, null: false
  end
end

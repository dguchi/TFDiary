class ChangeNumSetOfDiaryMenus < ActiveRecord::Migration
  def change
    change_column :diary_menus, :num, :integer, default: 0
    change_column :diary_menus, :set, :integer, default: 0
  end
end

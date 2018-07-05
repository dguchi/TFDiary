class AddColumnToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :approve_auto, :boolean, default: false
  end
end

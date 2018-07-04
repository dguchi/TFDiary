class AddColumnToNotice < ActiveRecord::Migration
  def change
    add_column :notices, :image_path, :string
  end
end

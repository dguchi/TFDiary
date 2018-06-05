class AddColumnToDiaryString < ActiveRecord::Migration
  def change
    add_column :diaries, :title, :string
  end
end

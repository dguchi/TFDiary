class Diary < ActiveRecord::Base
    has_many :diary_menus
    accepts_nested_attributes_for :diary_menus, allow_destroy: true, reject_if: :all_blank
    
    validates :user_id, :presence => true
    validates :date, :presence => true
end

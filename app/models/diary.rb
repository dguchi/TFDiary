class Diary < ActiveRecord::Base
    acts_as_followable

    has_many :diary_menus, dependent: :destroy
    accepts_nested_attributes_for :diary_menus, allow_destroy: true, reject_if: :all_blank
    
    validates :user_id, :presence => true
    validates :date, :presence => true
end

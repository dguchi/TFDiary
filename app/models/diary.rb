class Diary < ActiveRecord::Base
    acts_as_followable
    
    belongs_to :user
    belongs_to :group
    has_many :comments, dependent: :destroy
    has_many :diary_menus, dependent: :destroy
    accepts_nested_attributes_for :diary_menus, allow_destroy: true, reject_if: :all_blank
    
    validates :title, :presence => true
    validates :user_id_or_group_id, :presence => true
    validates :date, :presence => true
    
private
    def user_id_or_group_id
        user_id.presence or group_id.presence
    end
end

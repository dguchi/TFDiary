class DiaryMenu < ActiveRecord::Base
    belongs_to :diary

    validates :menu_id, presence: true
    validates :num, presence: true
    validates :set, presence: true
end

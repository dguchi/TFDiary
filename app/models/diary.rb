class Diary < ActiveRecord::Base
    validates :user_id, :presence => true
    validates :date, :presence => true
end

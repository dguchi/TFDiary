class Comment < ActiveRecord::Base
    belongs_to :diary
    
    validates :user_id, :presence => true
    validates :diary_id, :presence => true
    validates :content, :presence => true
end

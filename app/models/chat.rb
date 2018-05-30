class Chat < ActiveRecord::Base
    belongs_to :group 
    
    validates :content, :presence => true
    validates :user_id, :presence => true
    validates :group_id, :presence => true
end

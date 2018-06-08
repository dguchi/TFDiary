class GroupRequest < ActiveRecord::Base
    belongs_to :group
    
    validates :user_id, :presence => true, :uniqueness => {:scope => :group_id}
    validates :group_id, :presence => true
end

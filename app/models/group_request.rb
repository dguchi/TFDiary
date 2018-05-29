class GroupRequest < ActiveRecord::Base
    validates :user_id, :presence => true, :uniqueness => {:scope => :group_id}
    validates :group_id, :presence => true
end

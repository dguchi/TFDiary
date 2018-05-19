class Group < ActiveRecord::Base
    acts_as_followable
    
    validates :name, :presence => true
    validates :explain, :presence => true
    validates :leader_id, :presence => true
end

class Group < ActiveRecord::Base
    mount_uploader :image, GroupImagesUploader
    acts_as_followable
    
    validates :name, :presence => true
    validates :explain, :presence => true
    validates :leader_id, :presence => true
end

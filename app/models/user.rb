class User < ActiveRecord::Base
    has_secure_password
    mount_uploader :image, UserImagesUploader
    acts_as_followable
    acts_as_follower

    has_many :diaries, dependent: :destroy
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    
    validates :name, :presence => true
    validates :password_digest, :presence => true
    validates :mail, :presence => true,
                     :format => { with: VALID_EMAIL_REGEX },
                     :uniqueness => true
end

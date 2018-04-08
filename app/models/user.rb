class User < ActiveRecord::Base
    has_secure_password
    
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    
    validates :name, :presence => true
    validates :password_digest, :presence => true
    validates :mail, :presence => true,
                     :format => { with: VALID_EMAIL_REGEX },
                     :uniqueness => true
end

class User < ActiveRecord::Base
  mount_uploader :image, UserImagesUploader
  acts_as_followable
  acts_as_follower

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
  
  has_many :diaries, dependent: :destroy
  
  validates :name, :presence => true
end

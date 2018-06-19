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
  has_many :notices, dependent: :destroy
  
  validates :name, :presence => true
  
  def soft_delete
    update(deleted_at: Time.now)
  end
  
  def active_for_authentication?
    !deleted_at
  end
  
  def inactive_message
    !deleted_at ? super : :deleted_account
  end
end

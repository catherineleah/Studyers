require 'digest/sha2'

class User < ActiveRecord::Base
  # Added friendship model Amistad
  include Amistad::FriendModel
  
  validates :name, :presence => true
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :presence => true,
                    :uniqueness => true,
                    :format => { :with => email_regex }
  
  validates :password, :confirmation => true
  attr_accessor :password_confirmation
  attr_reader   :password
  
  validate :password_must_be_present
  
  after_destroy :ensure_an_admin_remains
  
  has_many :notebooks
  has_many :lessons, :through => :notebooks
  
  def ensure_an_admin_remains
    if User.count.zero?
      raise "Can't delete last user"
    end
  end
  
  def User.encrypt_password(password, salt)
      Digest::SHA2.hexdigest(password + "wibble" + salt)
  end
  
  def password=(password)
    @password = password
    
    if password.present?
      generate_salt
      self.hashed_password = self.class.encrypt_password(password, salt)
    end
  end
  
  def User.authenticate(email, password)
    if user = find_by_email(email)
      if user.hashed_password == encrypt_password(password, user.salt)
        user
      end
    end
  end
  
  def User.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end
  
  private
    
    def password_must_be_present
      errors.add(:password, "Missing password") unless hashed_password.present?
    end
    
    def generate_salt
      self.salt = self.object_id.to_s + rand.to_s
    end
    
end

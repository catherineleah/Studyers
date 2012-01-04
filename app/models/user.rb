class User < ActiveRecord::Base
  # Include default devise modules. 
  #  :registerable (out for alpha)
  # Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
  
  after_destroy :ensure_an_admin_remains
  
  has_many :notebooks
  has_many :lessons, :through => :notebooks
  
  private
    def ensure_an_admin_remains
      if User.find_by_admin(true)
        raise "Can't delete admin user"
      end
    end
end

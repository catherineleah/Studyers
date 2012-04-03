class User < ActiveRecord::Base
  # Include default devise modules. 
  # Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :registerable
  
  after_destroy :ensure_an_admin_remains
  
  has_many :notebooks
  has_many :courses
  has_many :lessons, :through => :notebooks
  has_many :course_lessons, :through => :courses
  
  after_create :send_welcome_mail
  after_create :create_default_notebook
  
  private
    def send_welcome_mail
      UserMailer.welcome_email(self.email, self.name).deliver
    end
  
    def create_default_notebook
      if self.role == "student"
        default = Notebook.new
        default.user_id = self.id
        default.name = "default notebook"
        default.save
      end
    end
    def ensure_an_admin_remains
      if User.find_by_admin(true)
        raise "Can't delete admin user"
      end
    end
end

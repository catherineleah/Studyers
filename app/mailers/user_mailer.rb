class UserMailer < ActionMailer::Base
  default from: "alpha@studyers.com"
  
  def welcome_email(email, name)
    @user = name
    @mail = email
    @url  = "http://studyers.com/users/sign_up"
    mail(:to => email, :subject => "Welcome to Studyers")
    end
end

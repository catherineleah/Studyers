class UserMailer < ActionMailer::Base
  default from: "alpha@studyers.com"
  
  def welcome_email(email, name)
    @user = name
    @mail = email
    @url  = "http://studyers.com/users/password/new"
    mail(:to => email, :subject => "Welcome to Studyers")
    end
end

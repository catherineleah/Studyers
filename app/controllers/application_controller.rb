class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  
  private
    def authenticate
      deny_access unless signed_in?
    end
  
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path, :notice => "Insufficient rights to prevented me from showing you this page") unless current_user?(@user) 
    end
end

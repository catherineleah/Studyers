class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  
  ## Cancan
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied !!!!"
    redirect_to root_url
  end
  
  private
    def authenticate
      deny_access unless signed_in?
    end
  
    def correct_user
      @user = User.find(params[:user_id])
      redirect_to(root_path, :notice => "Access denied !!") unless current_user?(@user) 
    end

end

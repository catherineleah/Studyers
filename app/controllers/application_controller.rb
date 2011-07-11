class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  
  ## Cancan
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "You have no permission to view this page"
    redirect_to profile_path
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

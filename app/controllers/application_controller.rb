class ApplicationController < ActionController::Base
  protect_from_forgery
  #include SessionsHelper
  
  before_filter :mobile_view_path
  before_filter :set_locale

  def set_locale
    if current_user
      I18n.locale = current_user.language || I18n.default_locale
    else
      I18n.locale = I18n.default_locale
    end
  end
  
  ## Cancan
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "You have no permission to view this lesson"
    redirect_to profile_path
  end
  
  def current_user?(user)
    user == current_user
  end
  
  private
    def mobile_view_path
      prepend_view_path "app/views/#{request.subdomain}_subdomain" if request.subdomain.present?
    end
  
    def authenticate
      deny_access unless user_signed_in?
    end
  
    def correct_user
      @user = User.find(params[:user_id])
      redirect_to(root_path, :notice => "Access denied !!") unless current_user?(@user) 
    end

end

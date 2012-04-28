class AdminController < ApplicationController

  def index
    @user = current_user
    if @user.admin?
      @users_count = User.count
      @notebooks_count = Notebook.count
      @lessons_count = Lesson.count
      @sign_ins = User.where("sign_in_count > 2").count
    else
      redirect_to profile_path
    end

  end
end

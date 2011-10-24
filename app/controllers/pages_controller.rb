class PagesController < ApplicationController
  def home
    redirect_to(profile_path) unless !signed_in?
    @lessons_count = Lesson.count
    @users_count = User.count
    @notebooks_count = Notebook.count
    @title = "The home of studyers"
  end

  def about
    @title = "About Us"
  end

  def contact
    @title = "Contact Us"
  end

end

class PagesController < ApplicationController
  def home
    @user = current_user
    @notebooks = @user.notebooks
    @title = "The home of studyrs"
  end

  def about
    @title = "About Us"
  end

  def contact
    @title = "Contact Us"
  end

end

class PagesController < ApplicationController
  def home
    
    @title = "The home of studyers"
  end

  def about
    @title = "About Us"
  end

  def contact
    @title = "Contact Us"
  end

end

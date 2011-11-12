class SessionsController < ApplicationController
  def new
  
  end

  def create
    user = User.authenticate(params[:session][:email], params[:session][:password])
    if user.nil?
      # Create an error message and re-render the signin form.
      flash.now[:error] = "Invalid Email / password combination." 
      @title = "Sign in"
      render 'new'
    else
      if params[:session][:remember_me] == "1"
        cookies.permanent.signed[:remember_token] = [user.id, user.salt]
      else
        cookies.signed[:remember_token] = [user.id, user.salt]
      end
      # Sign the user in and redirect to the user's show page.
      current_user = user
      redirect_to profile_path
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

end

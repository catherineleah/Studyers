class FriendsController < ApplicationController
  def invite
    current_user.invite User.find(params[:id])
    redirect_to(root_url, :notice => "Invitation was sent.")
  end

  def approve
    current_user.approve User.find(params[:id])
    redirect_to(root_url, :notice => "Friend request accepted.")
  end
end
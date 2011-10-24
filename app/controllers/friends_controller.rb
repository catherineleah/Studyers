class FriendsController < ApplicationController
  before_filter :authenticate, :only => [:index, :invite, :approve]

  def index
    @user = current_user
    @title = @user.name + " Friends"
    @friends = @user.friends
    
    respond_to do |format|
      format.html # index.html.erb
      format.json do
        render :json => @friends.map { |friend| {:id => friend.id, :name => friend.name} }
      end
    end
  end
  def invite
    current_user.invite User.find(params[:id])
    redirect_to(root_url, :notice => "Invitation was sent.")
  end

  def approve
    current_user.approve User.find(params[:id])
    redirect_to(root_url, :notice => "Friend request accepted.")
  end
end
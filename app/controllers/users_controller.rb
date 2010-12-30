class UsersController < ApplicationController
  before_filter :authenticate, :only => [:show, :edit, :update]
  before_filter :correct_user, :only => [:show, :edit, :update]
  # GET /users
  # GET /users.xml
  def index
    #@users = User.all
    @title = "All Users"
    @users = User.paginate(:page => params[:page])
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])
    @title = @user.name
    @notebooks = @user.notebooks
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new
    @title = "Signup to Studyr"
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

      if @user.save
        sign_in @user
        flash[:success] = "Welcome to Studyr!"
        redirect_to @user
      else
        render 'new'
      end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
  
  # Override the method in application controller
  private
  
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path, :notice => "Insufficient rights to prevented me from showing you this page") unless current_user?(@user) 
    end
  
end

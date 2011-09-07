class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :show, :edit, :update, :destroy, :new]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => [:new, :destroy]
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
    #@user = User.find(params[:id])
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end 
    @title = @user.name
    @notebooks = @user.notebooks.limit(3).order("updated_at DESC")
    @lessons = @user.lessons.limit(3).order("updated_at DESC")
  end

  def friends
    @user = current_user
    @title = @user.name + " Friends"
    @pending = @user.pending_invited_by
    @friends = @user.friends
  end
  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new
    @title = "Signup to Studyers"
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
        flash[:success] = "Welcome to Studyers!"
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

    def admin_user
      redirect_to(root_path, :notice => "We are in alpha mode and can't create new users yet") unless current_user.admin?
    end
  
end

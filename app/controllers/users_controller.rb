class UsersController < ApplicationController
  before_filter :authenticate_user!, :only => [:index, :show, :edit, :update, :destroy, :new]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => [:new, :destroy]
  before_filter :remove_admin_params, :only => [:create, :update]
  
  # GET /users
  # GET /users.xml
  def index
    #@users = User.all
    @title = "Who to follow"
    if (!current_user.study_at or current_user.study_at.empty?) and (!current_user.major or current_user.major.empty?)
      @users = User.order("RANDOM()").limit(16)
    #elsif  (!current_user.study_at or current_user.study_at.empty?) or (!current_user.major or current_user.major.empty?)
      
    else
      @users = User.where("(study_at like ? or major like ?) and id != ?", "%#{current_user.study_at}%", "%#{current_user.major}%", current_user.id).limit(16)
    end

    #json_users is an api to all users but current user
    @json_users = User.where("name like ? and id != ?", "%#{params[:q]}%", current_user.id)
    respond_to do |format|
      format.html # index.html.erb
      format.json do
        render :json => @json_users.map { |user| {:id => user.id, :name => user.name} }
      end
    end
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

    if role?(@user) == 'student'
      @notebooks = @user.notebooks.order("updated_at DESC")
      if @notebooks.length == 0
        @notebook = Notebook.new
      end
    elsif role?(@user) == 'teacher'
      @courses = @user.courses.order("updated_at DESC")
      if @courses.length == 0
        @course = Course.new
      end
    end
    #@lesson = Lesson.new
    #@lesson.shares.build
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
    @user = User.find(current_user.id)
    u = params[:user]
    if u[:password].blank? and u[:password].blank?
      if @user.update_without_password(u)
        redirect_to(@user, :notice => 'User was successfully updated.')
      else
        render :action => "edit"
      end
    else
      if @user.update_attributes(u)
        redirect_to(@user, :notice => 'User was successfully updated.')
      else
        render :action => "edit"
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
      redirect_to(root_path, :notice => "Insufficient rights to prevented me from showing you this page") unless current_user?(@user) or current_user.admin? 
    end

    def admin_user
      redirect_to(root_path, :notice => "We are in alpha mode and can't create new users yet") unless current_user.admin?
    end
    
    def current_user?(user)
      user == current_user
    end
    
    def role?(user)
      return user.role
    end
    
    # protect vs. mass assignment of admin.
    def remove_admin_params
      params[:user].delete(:admin) unless current_user.admin?
    end
end

class NotebooksController < ApplicationController
  before_filter :authenticate_user!, :only => [:index, :show, :edit, :update]
  before_filter :correct_user, :only => [:edit, :update]
  # GET /notebooks
  # GET /notebooks.xml
  def index
    @user = current_user
    @notebooks = @user.notebooks.order("updated_at DESC")
    @title = "My notebooks"
  end

  # GET /notebooks/1
  # GET /notebooks/1.xml
  def show
    @user = current_user
    @notebook = @user.notebooks.find(params[:id])
    @title = @notebook.name
    @lessons = @notebook.lessons
    if @lessons.length == 0
      @lesson = Lesson.new
    end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @notebook }
    end
  end

  # GET /notebooks/new
  # GET /notebooks/new.xml
  def new
    #@user = current_user
    @notebook = Notebook.new
  end

  # GET /notebooks/1/edit
  def edit
    @user = current_user
    @notebook = @user.notebooks.find(params[:id])
  end

  # POST /notebooks
  # POST /notebooks.xml
  def create
    @notebook = current_user.notebooks.build(params[:notebook])
    
      if @notebook.save
        flash[:success] ="Saved a new notebook"
        redirect_to @notebook
      else
        render :action => "new" 
      end
  end

  # PUT /notebooks/1
  # PUT /notebooks/1.xml
  def update
    @user = current_user
    @notebook = @user.notebooks.find(params[:id])
    if @notebook.update_attributes(params[:notebook])
      flash[:notice] = "Successfully updated"
      redirect_to notebooks_path
    else
      render :action => "edit" 
    end
  end

  # DELETE /notebooks/1
  # DELETE /notebooks/1.xml
  def destroy
    @user = current_user
    @notebook = @user.notebooks.find(params[:id])
    @notebook.destroy

    respond_to do |format|
      format.html { redirect_to user_notebooks_path }
      format.js  { render :nothing => true }
    end
  end
end

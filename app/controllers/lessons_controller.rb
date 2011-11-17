class LessonsController < ApplicationController
  # cancan authorize
  load_and_authorize_resource
  
  before_filter :authenticate, :only => [:index, :show, :edit, :update, :destroy]
    
  before_filter :find_notebook, :only => [:new]
  
  # GET notebook/:id/lessons
  def index
    @user = current_user
    @notebook = Notebook.find(params[:notebook_id])
    @lessons = @notebook.lessons.order("updated_at DESC")
    @title = @notebook.name   
  end

  # GET notebook/:id/lessons/1
  def show
    @user = current_user
    @notebook = Notebook.find(params[:notebook_id])
    @lesson =  @notebook.lessons.find(params[:id])
  end

  # GET notebook/:id/lessons/new
  def new
    @user = current_user
    @lesson = Lesson.new
    @lesson.shares.build
  end

  # GET notebook/:id/lessons/1/edit
  def edit
    @user = current_user
    @notebook = current_user.notebooks.find(params[:notebook_id])
    @lesson =  @notebook.lessons.find(params[:id])

    shared_ids = @lesson.shares.map(&:shared_ids) unless @lesson.shares.map(&:shared_ids).empty?
    @shared_ids = []
    if !shared_ids.empty?
      shared_ids.each do | id |
        if !id.empty? 
          @user = User.find(id, :select => "id, name")
          @shared_ids.push(@user)
        end
      end
    end
    @shared_ids = @shared_ids.to_json
    @shared_ids["["] =""
    @shared_ids["]"] =""
  end

  # POST notebook/:id/lessons
  def create
    @notebook = current_user.notebooks.find(params[:notebook_id])
    @lesson =  @notebook.lessons.build(params[:lesson])
    @lesson.user_id = @notebook.user_id

    if @lesson.save
      flash[:success] ="Saved lesson successfully"
      redirect_to notebook_lessons_path
    else
       render :action => "new" 
    end
  end

  # PUT notebook/:id/lessons/1
  def update
    @notebook = current_user.notebooks.find(params[:notebook_id])
    @lesson = @notebook.lessons.find(params[:id])
    if @lesson.update_attributes(params[:lesson])
      flash[:success] = 'Lesson was successfully updated.'
      redirect_to notebook_lessons_path
    else
      render :action => "edit" 
    end
    
  end

  # DELETE /lessons/1
  # DELETE /lessons/1.xml
  def destroy
    @notebook = current_user.notebooks.find(params[:notebook_id])
    @lesson = @notebook.lessons.find(params[:id])
    @lesson.destroy

    respond_to do |format|
      format.html { redirect_to(notebook_lessons_path) }
      format.js  { render :nothing => true }
    end
  end
  
  protected
    ##
    # Make sure the notebook is picked when creating a new lesson
    ##
    def find_notebook
      @notebook = current_user.notebooks.find(params[:notebook_id])
    end
    
end

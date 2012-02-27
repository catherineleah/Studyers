class LessonsController < ApplicationController
  # cancan authorize
  load_and_authorize_resource
  
  before_filter :authenticate_user!, :only => [:index, :show, :edit, :update, :destroy, :shared, :new]
    
  before_filter :find_notebook, :only => [:new]
  
  # GET notebook/:id/lessons
  def index
    @user = current_user
    @notebook = Notebook.find(params[:notebook_id])
    @lessons = @notebook.lessons.order("updated_at DESC")
    if @lessons.count == 0 && current_user.id == @notebook.user_id
      redirect_to(new_notebook_lesson_path(@notebook))
    end
    @title = @notebook.name   
  end

  # GET notebook/:id/lessons/1
  def show
    @user = current_user
    @notebook = Notebook.find(params[:notebook_id])
    @lesson =  @notebook.lessons.find(params[:id])
    @author = User.find(@lesson.user_id)
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
    
    shared_ids = []
    shared_ids = @lesson.shares.where("lesson_id = ?", @lesson.id)
    @shared_ids = []
    unless shared_ids.nil?
      shared_ids.each do | id |
        if !id[:shared_ids].empty? 
          @user = User.find(id[:shared_ids], :select => "id, name")
          @shared_ids.push(@user)
        end
      end
      @shared_ids = @shared_ids.to_json
    else
      @lesson.shares.build
    end
    @lesson.shares.build
  end

  # POST notebook/:id/lessons
  def create
    @notebook = current_user.notebooks.find(params[:notebook_id])
    @lesson =  @notebook.lessons.build(params[:lesson])
    @lesson.user_id = @notebook.user_id
    @ids = params[:lesson][:shares_attributes]['0'][:shared_token].split(',')
    @lesson.build_shares_from_list @ids
    
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
    Share.destroy(@lesson.shares)
    @ids = params[:lesson][:shares_attributes]['0'][:shared_token].split(',')
    @lesson.build_shares_from_list @ids
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
  
  def shared
    @user = current_user
    @shared = shared_lesson @user.id
  end
  
  
  protected
    ##
    # Make sure the notebook is picked when creating a new lesson
    ##
    def find_notebook
      if(params[:notebook_id])
        @notebook = current_user.notebooks.find(params[:notebook_id])
      end
    end
    
  private
  
    def shared_lesson(user)
      lessons = Array.new { Hash.new }
      l = Hash.new
      shared = Share.where("shared_ids = ?", user)
      shared.each do |share|
        lesson = Lesson.find(share[:lesson_id])
        notebook = Notebook.find(lesson.notebook_id)
        user = User.find(lesson.user_id)
        l = { lesson.title => notebook_lesson_path(lesson.notebook_id, lesson.id) }, { notebook.name => notebook_lessons_path(notebook.id) }, { user.name => user_path(user.id) }
        lessons << l
      end
      return lessons
    end
    
    
end

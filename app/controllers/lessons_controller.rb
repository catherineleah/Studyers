class LessonsController < ApplicationController
  # cancan authorize
  authorize_resource 
  before_filter :authenticate, :only => [:index, :show, :edit, :update, :destroy]
  
  # A filter for current user
  #before_filter :notebook_owner, :only => [:edit, :update, :destroy]
  
  before_filter :find_notebook, :only => [:new]

  uses_tiny_mce :options => {
                              :theme => 'advanced',
                              :width => '800px',
                              :theme_advanced_resizing => false,
                              :theme_advanced_resize_horizontal => false,
                              :theme_advanced_toolbar_location => "top",
                              :theme_advanced_toolbar_align => "left",
                              :theme_advanced_buttons1 => "bold,italic,underline,separator,justifyleft,justifycenter,justifyright,justifyfull,separator,bullist,numlist,separator,outdent,indent,separator,undo,redo,separator,link,unlink,table,tablecontrols,|,insertdate,inserttime,preview,|,forecolor,backcolor",
                              :theme_advanced_buttons2 => "",
                              :theme_advanced_buttons3 => "",
                              :plugins => %w{ table fullscreen }
                            }
  
  # GET notebook/:id/lessons
  def index
    @current_user = current_user
    #@notebook = current_user.notebooks.find(params[:notebook_id])
    @notebook = Notebook.find(params[:notebook_id])
    @lessons = @notebook.lessons
    @title = @notebook.name   
  end

  # GET notebook/:id/lessons/1
  def show
    #@notebook = current_user.notebooks.find(params[:notebook_id])
    @current_user = current_user
    @notebook = Notebook.find(params[:notebook_id])
    @lesson =  @notebook.lessons.find(params[:id])
  end

  # GET notebook/:id/lessons/new
  def new
    @lesson = Lesson.new
  end

  # GET notebook/:id/lessons/1/edit
  def edit
    @notebook = current_user.notebooks.find(params[:notebook_id])
    @lesson =  @notebook.lessons.find(params[:id])
  end

  # POST notebook/:id/lessons
  def create
    @notebook = current_user.notebooks.find(params[:notebook_id])
    @lesson =  @notebook.lessons.build(params[:lesson])
    @lesson.user_id = @notebook.user_id

    if @lesson.save
    flash[:notice] =" Success"
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
      flash[:notice] = 'Lesson was successfully updated.'
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
      format.xml  { head :ok }
    end
  end
  
  protected
    ##
    # Make sure the notebook is picked when creating a new lesson
    ##
    def find_notebook
      @notebook = current_user.notebooks.find(params[:notebook_id])
    end

  
  private
    ##
    # A method to make sure that the lesson is watched / edited 
    # by the notebook owner. 
    # (Not sure the best way it can be done - but it works)
    ##
    def notebook_owner
      @notebook = Notebook.find(params[:notebook_id])
      @user = User.find(@notebook.user_id)
      redirect_to(root_path, :notice => "This Lesson is marked as private, and can not be watched.") unless current_user?(@user) 
    end
end

class LessonsController < ApplicationController
  before_filter :authenticate, :only => [:index, :show, :edit, :update]
  # @TODO: add a filter for current user
  # before_filter :notebook_owner, :only => [:show, :edit, :update]
  before_filter :find_album
  
  # GET notebook/:id/lessons
  def index
    
    @notebook = current_user.notebooks.find(params[:notebook_id])
    @lessons = @notebook.lessons

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @lessons }
    end
  end

  # GET notebook/:id/lessons/1
  def show
    @notebook = current_user.notebooks.find(params[:notebook_id])
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
      ################################
      ## Bug here with form...      ##
      ## @notebook in the form      ##
      ## will work (but then it     ##
      ## screws create)  FIXED??    ##
      ################################
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
    def find_album
      @notebook = current_user.notebooks.find(params[:notebook_id])
    end
  
  private
    def notebook_owner
      @notebook = current_user.notebooks.find(params[:notebook_id])
      @user = User.find(params[@notebook.user_id])
      redirect_to(root_path, :notice => "Insufficient rights to prevented me from showing you this page") unless current_user?(@user) 
    end
end

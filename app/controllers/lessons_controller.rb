class LessonsController < ApplicationController
  #before_filter :authenticate, :only => [:edit, :update]
  #before_filter :correct_user, :only => [:show, :edit, :update]
  # GET /lessons
  # GET /lessons.xml
  def index
    #@lessons = Lesson.all
    @notebook = Notebook.find(params[:notebook_id])
    @lessons = @notebook.lessons

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @lessons }
    end
  end

  # GET /lessons/1
  # GET /lessons/1.xml
  def show
    @notebook = Notebook.find(params[:notebook_id])
    @lesson =  @notebook.lessons.find(params[:id])

  end

  # GET /lessons/new
  # GET /lessons/new.xml
  def new
    @lesson = Lesson.new
  end

  # GET /lessons/1/edit
  def edit
    @notebook = Notebook.find(params[:notebook_id])
    @lesson =  @notebook.lessons.find(params[:id])
  end

  # POST /lessons
  # POST /lessons.xml
  def create
    #@lesson = Lesson.new(params[:lesson])
    @notebook = Notebook.find(params[:notebook_id])
    @lesson =  @notebook.lessons.build(params[:lesson])
    @lesson.user_id = @notebook.user_id

      if @lesson.save
      flash[:notice] =" Success"
      redirect_to notebook_lessons_path
      else
         render :action => "new" 
      end

  end

  # PUT /lessons/1
  # PUT /lessons/1.xml
  def update
    @lesson = Lesson.find(params[:id])

    respond_to do |format|
      if @lesson.update_attributes(params[:lesson])
        format.html { redirect_to(@lesson, :notice => 'Lesson was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @lesson.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /lessons/1
  # DELETE /lessons/1.xml
  def destroy
    @lesson = Lesson.find(params[:id])
    @lesson.destroy

    respond_to do |format|
      format.html { redirect_to(notebook_lessons_path) }
      format.xml  { head :ok }
    end
  end
end

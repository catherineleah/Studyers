class CoursesController < ApplicationController
  # cancan authorize
  load_and_authorize_resource
  
  before_filter :authenticate_user!, :only => [:index, :new, :show, :edit, :update]
  
  # GET /courses
  # GET /courses.json
  def index
    @user = current_user
    @courses = @user.courses.order("updated_at DESC")
    if @courses.length == 0
      @course = Course.new
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @courses }
    end
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @user = current_user
    ## Need to figure out here.... ##
    @course = Course.find(params[:id])
    @course_lessons = @course.course_lessons
    @title = @course.name
    if @course_lessons.length == 0 && current_user.id == @course.user_id
      redirect_to new_course_course_lesson_path(@course)
      return
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @course }
    end
  end

  # GET /courses/new
  # GET /courses/new.json
  def new
    @course = Course.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @course }
    end
  end

  # GET /courses/1/edit
  def edit
    @user = current_user
    @course = @user.courses.find(params[:id])
  end

  # POST /courses
  # POST /courses.json
  def create
    @user = current_user
    @course = @user.courses.build(params[:course])

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render json: @course, status: :created, location: @course }
      else
        format.html { render action: "new" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /courses/1
  # PUT /courses/1.json
  def update
    @user = current_user
    @course = @user.courses.find(params[:id])

    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course = current_user.courses.find(params[:id])
    @course.destroy

    respond_to do |format|
      format.html { redirect_to courses_url }
      format.json { head :ok }
    end
  end
end

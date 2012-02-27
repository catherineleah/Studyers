class CourseLessonsController < ApplicationController
  before_filter :authenticate_user!, :only => [:index, :show, :edit, :update, :destroy, :shared]
  
  before_filter :find_course, :only => [:new]
  # GET /course_lessons
  # GET /course_lessons.json
  def index
    @user = current_user
    @course = Course.find(params[:course_id])
    @course_lessons = @course.course_lessons.order("updated_at DESC")
    if @course_lessons.count == 0
      @course_lesson = CourseLesson.new
    end
    @title = @course.name

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @course_lessons }
    end
  end

  # GET /course_lessons/1
  # GET /course_lessons/1.json
  def show
    #@course = Course.find(params[:course_id])
    @course_lesson = CourseLesson.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @course_lesson }
    end
  end

  # GET /course_lessons/new
  # GET /course_lessons/new.json
  def new
    @user = current_user
    @course_lesson = CourseLesson.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @course_lesson }
    end
  end

  # GET /course_lessons/1/edit
  def edit
    @course = current_user.courses.find(params[:course_id])
    @course_lesson = @course.course_lessons.find(params[:id])
  end

  # POST /course_lessons
  # POST /course_lessons.json
  def create
    @course = current_user.courses.find(params[:course_id])
    @course_lesson = @course.course_lessons.build(params[:course_lesson])
    @course_lesson.user_id = @course.user_id

    respond_to do |format|
      if @course_lesson.save
        format.html { redirect_to @course, notice: 'Course lesson was successfully created.' }
        format.json { render json: @course_course_lesson, status: :created, location: @course_lesson }
      else
        format.html { render action: "new" }
        format.json { render json: @course_lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /course_lessons/1
  # PUT /course_lessons/1.json
  def update
    @course = current_user.courses.find(params[:course_id])
    @course_lesson = @course.course_lessons.find(params[:id])
    respond_to do |format|
      if @course_lesson.update_attributes(params[:course_lesson])
        format.html { redirect_to @course, notice: 'Course lesson was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @course_lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_lessons/1
  # DELETE /course_lessons/1.json
  def destroy
    @course_lesson = CourseLesson.find(params[:id])
    @course_lesson.destroy

    respond_to do |format|
      format.html { redirect_to course_lessons_url }
      format.json { head :ok }
    end
  end
  
  protected
    def find_course
      if(params[:course_id])
        @course = current_user.courses.find(params[:course_id])
      end
    end
end

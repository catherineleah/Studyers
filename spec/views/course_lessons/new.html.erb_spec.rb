require 'spec_helper'

describe "course_lessons/new.html.erb" do
  before(:each) do
    assign(:course_lesson, stub_model(CourseLesson,
      :course => nil,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new course_lesson form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => course_lessons_path, :method => "post" do
      assert_select "input#course_lesson_course", :name => "course_lesson[course]"
      assert_select "input#course_lesson_name", :name => "course_lesson[name]"
    end
  end
end

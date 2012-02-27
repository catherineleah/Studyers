require 'spec_helper'

describe "course_lessons/show.html.erb" do
  before(:each) do
    @course_lesson = assign(:course_lesson, stub_model(CourseLesson,
      :course => nil,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end

require 'spec_helper'

describe "course_lessons/index.html.erb" do
  before(:each) do
    assign(:course_lessons, [
      stub_model(CourseLesson,
        :course => nil,
        :name => "Name"
      ),
      stub_model(CourseLesson,
        :course => nil,
        :name => "Name"
      )
    ])
  end

  it "renders a list of course_lessons" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end

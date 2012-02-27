require 'spec_helper'

describe "courses/new.html.erb" do
  before(:each) do
    assign(:course, stub_model(Course,
      :user_id => nil,
      :name => "MyString",
      :number => "MyString",
      :department => "MyString",
      :term => "MyString",
      :school => "MyString"
    ).as_new_record)
  end

  it "renders new course form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => courses_path, :method => "post" do
      assert_select "input#course_user_id", :name => "course[user_id]"
      assert_select "input#course_name", :name => "course[name]"
      assert_select "input#course_number", :name => "course[number]"
      assert_select "input#course_department", :name => "course[department]"
      assert_select "input#course_term", :name => "course[term]"
      assert_select "input#course_school", :name => "course[school]"
    end
  end
end

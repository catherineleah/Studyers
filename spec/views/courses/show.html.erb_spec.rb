require 'spec_helper'

describe "courses/show.html.erb" do
  before(:each) do
    @course = assign(:course, stub_model(Course,
      :user_id => nil,
      :name => "Name",
      :number => "Number",
      :department => "Department",
      :term => "Term",
      :school => "School"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Number/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Department/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Term/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/School/)
  end
end

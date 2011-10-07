require 'spec_helper'

describe "class_resources/show.html.erb" do
  before(:each) do
    @class_resource = assign(:class_resource, stub_model(ClassResource,
      :title => "Title",
      :presentation => "Presentation"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Presentation/)
  end
end

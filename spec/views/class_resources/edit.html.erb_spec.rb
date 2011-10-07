require 'spec_helper'

describe "class_resources/edit.html.erb" do
  before(:each) do
    @class_resource = assign(:class_resource, stub_model(ClassResource,
      :title => "MyString",
      :presentation => "MyString"
    ))
  end

  it "renders the edit class_resource form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => class_resources_path(@class_resource), :method => "post" do
      assert_select "input#class_resource_title", :name => "class_resource[title]"
      assert_select "input#class_resource_presentation", :name => "class_resource[presentation]"
    end
  end
end

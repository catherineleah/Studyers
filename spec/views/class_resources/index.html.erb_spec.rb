require 'spec_helper'

describe "class_resources/index.html.erb" do
  before(:each) do
    assign(:class_resources, [
      stub_model(ClassResource,
        :title => "Title",
        :presentation => "Presentation"
      ),
      stub_model(ClassResource,
        :title => "Title",
        :presentation => "Presentation"
      )
    ])
  end

  it "renders a list of class_resources" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Presentation".to_s, :count => 2
  end
end

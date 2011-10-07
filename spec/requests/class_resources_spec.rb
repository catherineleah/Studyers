require 'spec_helper'

describe "ClassResources" do
  describe "GET /class_resources" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get class_resources_path
      response.status.should be(200)
    end
  end
end

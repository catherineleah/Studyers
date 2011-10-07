require "spec_helper"

describe ClassResourcesController do
  describe "routing" do

    it "routes to #index" do
      get("/class_resources").should route_to("class_resources#index")
    end

    it "routes to #new" do
      get("/class_resources/new").should route_to("class_resources#new")
    end

    it "routes to #show" do
      get("/class_resources/1").should route_to("class_resources#show", :id => "1")
    end

    it "routes to #edit" do
      get("/class_resources/1/edit").should route_to("class_resources#edit", :id => "1")
    end

    it "routes to #create" do
      post("/class_resources").should route_to("class_resources#create")
    end

    it "routes to #update" do
      put("/class_resources/1").should route_to("class_resources#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/class_resources/1").should route_to("class_resources#destroy", :id => "1")
    end

  end
end

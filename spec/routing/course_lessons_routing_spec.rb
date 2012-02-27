require "spec_helper"

describe CourseLessonsController do
  describe "routing" do

    it "routes to #index" do
      get("/course_lessons").should route_to("course_lessons#index")
    end

    it "routes to #new" do
      get("/course_lessons/new").should route_to("course_lessons#new")
    end

    it "routes to #show" do
      get("/course_lessons/1").should route_to("course_lessons#show", :id => "1")
    end

    it "routes to #edit" do
      get("/course_lessons/1/edit").should route_to("course_lessons#edit", :id => "1")
    end

    it "routes to #create" do
      post("/course_lessons").should route_to("course_lessons#create")
    end

    it "routes to #update" do
      put("/course_lessons/1").should route_to("course_lessons#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/course_lessons/1").should route_to("course_lessons#destroy", :id => "1")
    end

  end
end

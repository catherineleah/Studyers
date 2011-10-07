class ClassResourcesController < ApplicationController
  # GET /class_resources
  # GET /class_resources.json
  def index
    @class_resources = ClassResource.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @class_resources }
    end
  end

  # GET /class_resources/1
  # GET /class_resources/1.json
  def show
    @class_resource = ClassResource.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @class_resource }
    end
  end

  # GET /class_resources/new
  # GET /class_resources/new.json
  def new
    @class_resource = ClassResource.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @class_resource }
    end
  end

  # GET /class_resources/1/edit
  def edit
    @class_resource = ClassResource.find(params[:id])
  end

  # POST /class_resources
  # POST /class_resources.json
  def create
    @class_resource = ClassResource.new(params[:class_resource])

    respond_to do |format|
      if @class_resource.save
        format.html { redirect_to @class_resource, notice: 'Class resource was successfully created.' }
        format.json { render json: @class_resource, status: :created, location: @class_resource }
      else
        format.html { render action: "new" }
        format.json { render json: @class_resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /class_resources/1
  # PUT /class_resources/1.json
  def update
    @class_resource = ClassResource.find(params[:id])

    respond_to do |format|
      if @class_resource.update_attributes(params[:class_resource])
        format.html { redirect_to @class_resource, notice: 'Class resource was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @class_resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /class_resources/1
  # DELETE /class_resources/1.json
  def destroy
    @class_resource = ClassResource.find(params[:id])
    @class_resource.destroy

    respond_to do |format|
      format.html { redirect_to class_resources_url }
      format.json { head :ok }
    end
  end
end

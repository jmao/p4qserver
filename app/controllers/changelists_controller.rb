class ChangelistsController < ApplicationController
  # GET /changelists
  # GET /changelists.json
  def index
    @changelists = Changelist.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @changelists }
    end
  end

  # GET /changelists/1
  # GET /changelists/1.json
  def show
    @changelist = Changelist.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @changelist }
    end
  end

  # GET /changelists/new
  # GET /changelists/new.json
  def new
    @changelist = Changelist.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @changelist }
    end
  end

  # GET /changelists/1/edit
  def edit
    @changelist = Changelist.find(params[:id])
  end

  # POST /changelists
  # POST /changelists.json
  def create
    @changelist = Changelist.new(params[:changelist])

    respond_to do |format|
      if @changelist.save
        format.html { redirect_to @changelist, notice: 'Changelist was successfully created.' }
        format.json { render json: @changelist, status: :created, location: @changelist }
      else
        format.html { render action: "new" }
        format.json { render json: @changelist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /changelists/1
  # PUT /changelists/1.json
  def update
    @changelist = Changelist.find(params[:id])

    respond_to do |format|
      if @changelist.update_attributes(params[:changelist])
        format.html { redirect_to @changelist, notice: 'Changelist was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @changelist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /changelists/1
  # DELETE /changelists/1.json
  def destroy
    @changelist = Changelist.find(params[:id])
    @changelist.destroy

    respond_to do |format|
      format.html { redirect_to changelists_url }
      format.json { head :ok }
    end
  end
end

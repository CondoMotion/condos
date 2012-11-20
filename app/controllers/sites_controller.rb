class SitesController < ApplicationController
  before_filter :authenticate_user!, :except => :show
  before_filter :load_site, :only => :show
  load_and_authorize_resource :except => :show

  # GET /sites
  # GET /sites.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sites }
    end
  end

  # GET /sites/1
  # GET /sites/1.json
  def show
    @site = @current_site
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /sites/new
  # GET /sites/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { head :no_content }
    end
  end

  # GET /sites/1/edit
  def edit
  end

  # POST /sites
  # POST /sites.json
  def create
    @site.company_id = current_company.id
    respond_to do |format|
      if @site.save
        format.html { redirect_to root_url(subdomain: @site.subdomain), notice: 'Site was successfully created.' }
      else
        format.html { render action: "new" }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sites/1
  # PUT /sites/1.json
  def update

    respond_to do |format|
      if @site.update_attributes(params[:site])
        format.html { redirect_to root_url(subdomain: @site.subdomain), notice: 'Site was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sites/1
  # DELETE /sites/1.json
  def destroy
    @site.destroy

    respond_to do |format|
      format.html { redirect_to sites_url }
      format.json { head :no_content }
    end
  end
end

class MembershipsController < ApplicationController
	before_filter :authenticate_user!
	load_and_authorize_resource
  # GET /memberships
  # GET /memberships.json
  def index
    @memberships = @memberships.order(:site_id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @memberships }
    end
  end

  # GET /memberships/1
  # GET /memberships/1.json
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @membership }
    end
  end

  # GET /memberships/new
  # GET /memberships/new.json
  def new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @membership }
    end
  end

  # GET /memberships/1/edit
  def edit

  end

  # POST /memberships
  # POST /memberships.json
  def create
  	@site = Site.find(params[:membership][:site_id])
  	if @site.temp_pw
  		@pw = @site.temp_pw
  	else
  		@pw = "temp123"
  	end

  	if current_company.users.find_by_email(params[:email]).nil?
  		@user = User.new(:email => params[:email])
  		@user.password = @pw
  		@user.password_confirmation = @pw
  		@user.company = current_company
  		# This should probably have additional logic and not allow any user to become a manager...
  		if params[:membership][:role] == "manager"
  			@user.manager = 1
  		end
  	else
  		@user = current_company.users.find_by_email!(params[:email])  		
  	end

    @membership.site = @site
    @membership.user = @user
    @membership.role = params[:membership][:role]

    respond_to do |format|
      if @membership.save
        format.html { redirect_to @membership, notice: 'Membership was successfully created.' }
        format.json { render json: @membership, status: :created, location: @membership }
      else
        format.html { render action: "new" }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /memberships/1
  # PUT /memberships/1.json
  def update

    respond_to do |format|
      if @membership.update_attributes(params[:membership])
        format.html { redirect_to @membership, notice: 'Membership was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memberships/1
  # DELETE /memberships/1.json
  def destroy
    @membership.destroy

    respond_to do |format|
      format.html { redirect_to memberships_url }
      format.json { head :no_content }
    end
  end
end

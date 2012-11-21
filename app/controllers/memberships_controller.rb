class MembershipsController < ApplicationController
	before_filter :authenticate_user!
	load_and_authorize_resource
	skip_authorize_resource :only => [:batch_create_residents, :batch_create_managers]
  # GET /memberships
  # GET /memberships.json
  def index
    @memberships = @memberships.order(:site_id, :role)

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
  	@o =  [('a'..'z'),('A'..'Z'), (0..9)].map{|i| i.to_a}.flatten
		@pw = (0...8).map{ @o[rand(@o.length)] }.join

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

  def batch_create_managers
		params[:emails].split(",").each do |email|
			@o =  [('a'..'z'),('A'..'Z'), (0..9)].map{|i| i.to_a}.flatten
			@pw = (0...8).map{ @o[rand(@o.length)] }.join
			if current_company.users.find_by_email(email).nil?
		    @user = current_company.users.new(
		    	:email => email,
		    	:password => @pw,
		    	:password_confirmation => @pw,
		    	:manager => 1
		    )
		  else
		  	@user = current_company.users.find_by_email(email)
		  end
		    @user.save
	  end
	  respond_to do |format|
	  	format.html { redirect_to sites_url, notice: 'Managers were successfully added.' }
	  end
  end

  def batch_create_residents
  	params[:emails].split(",").each do |email|
			@o =  [('a'..'z'),('A'..'Z'), (0..9)].map{|i| i.to_a}.flatten
			@pw = (0...8).map{ @o[rand(@o.length)] }.join

			@site = Site.find(params[:site_id])

	    if current_company.users.find_by_email(email).nil?
		    @user = current_company.users.new(
		    	:email => email,
		    	:password => @pw,
		    	:password_confirmation => @pw,
		    	:manager => 0
		    )
		  else
		  	@user = current_company.users.find_by_email(email)
		  end

	    if Membership.find_by_user_id_and_site_id_and_role(@user.id, @site.id, 'resident').nil?
	    	@membership = Membership.new()
	    	@membership.user = @user
	    	@membership.site = @site
	    	@membership.role = 'resident'
	    else
	    	@membership = Membership.find_by_user_id_and_site_id_and_role(@user.id, @site.id, 'resident')
	    end

	    @membership.save

	  end
	  respond_to do |format|
	  	format.html { redirect_to edit_site_url(@site), notice: 'Residents were successfully added.' }
	  end
  end
end

class PostsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_site, :only => :show

  load_and_authorize_resource
  # GET /posts
  # GET /posts.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @sites = current_company.sites
    if params[:post_type]
      @post.post_type = params[:post_type]
    else
      @post.post_type = "news"
    end
    if request.subdomain.present? && request.subdomain != "www"
      @post.site = Site.find_by_subdomain(request.subdomain)
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @sites = current_company.sites
  end

  # POST /posts
  # POST /posts.json
  def create
    @sites = current_company.sites
    @post.user = current_user

    respond_to do |format|
      if @post.save
        if @post.attachment?
          PostMailer.new_post(@post, request.protocol + request.host_with_port + @post.attachment.url).deliver
        else
          PostMailer.new_post(@post, "").deliver
        end

        format.html { redirect_to post_url(@post, subdomain: @post.site.subdomain), notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to post_url(@post, subdomain: @post.site.subdomain), notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
end

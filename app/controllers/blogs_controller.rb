require 'benchmark'

class BlogsController < ApplicationController
  before_action :set_blog, only: %i[ show edit update destroy publish ]

  # GET /blogs
  def index
    benchmark_result = Benchmark.measure do
      @blogs = Blog.published
    end

    Rails.logger.info "Blog Index Query Benchmark: #{benchmark_result}"
  end

  # GET /blogs/drafts
  def drafts
    @blogs = Blog.drafts
  end

  # GET /blogs/1
  def show
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  def create
    @blog = Blog.new(blog_params)

    respond_to do |format|
      if @blog.save
        # Schedule auto-publish job for 1 hour from now
        Blogs::AutoPublishJob.set(wait: 1.hour).perform_later(@blog.id)

        format.html { redirect_to @blog, notice: "Blog was successfully created." }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog, notice: "Blog was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  def destroy
    @blog.destroy!

    respond_to do |format|
      format.html { redirect_to blogs_path, notice: "Blog was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  # PATCH /blogs/1/publish
  def publish
    result = Blogs::PublishingService.call(@blog)

    if result[:success]
      render json: { status: "published", blog: result[:blog] }
    else
      render json: { status: "error", message: result[:error] }, status: :unprocessable_entity
    end
  end

  private

  def set_blog
    @blog = Blog.find(params.expect(:id))
  end

  def blog_params
    params.require(:blog).permit(:title, :body, :published)
  end
end

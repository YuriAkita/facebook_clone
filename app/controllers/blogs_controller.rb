class BlogsController < ApplicationController
  before_action :set_blog, only: %i[ show edit update destroy ]

  def index
    @blogs = Blog.all
  end

  def show
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end

  def new
    @blog = Blog.new
  end

  def edit
  end

  def create
    @blog = current_user.blogs.build(blog_params)
    if params[:back]
      render :new
    else
      respond_to do |format|
        if @blog.save
          format.html { redirect_to @blog, notice: "Blog was successfully created." }
          format.json { render :show, status: :created, location: @blog }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @blog.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog, notice: "Blog was successfully updated." }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: "Blog was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def confirm
  @blog = current_user.blogs.build(blog_params)
  render :new if @blog.invalid?
  end

  private
    def set_blog
      @blog = Blog.find(params[:id])
    end

    def blog_params
      params.require(:blog).permit(:image, :image_cache, :content, :user_id)
    end
end

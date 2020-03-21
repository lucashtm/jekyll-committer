class BlogsController < ApplicationController
  before_action :authenticate_user!

  def show
    @blog = Blog.find(params[:id])
    @post = Post.new
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(create_params)
    @blog.save
    redirect_to dashboard_path
  end

  private

  def create_params
    params.require(:blog)
          .permit(:repo, :branch, :name)
          .merge(user_id: current_user.id)
  end
end

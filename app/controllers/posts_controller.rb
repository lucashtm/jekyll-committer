class PostsController < ApplicationController
  def create
    @post = Post.new(create_params)
    @post.save
    uploader = Posts::Uploader.new(@post)
    uploader.call
    redirect_to blog_path(create_params[:blog_id])
  end

  private

  def create_params
    params.require(:post).permit(:title, :content, :blog_id)
  end
end

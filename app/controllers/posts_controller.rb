class PostsController < ApplicationController
  def index
    binding.pry
    @posts = Post.all.where(user: current_user)
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created!"
      redirect_to posts_path
    end
  end

  def new
    @post = Post.new
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end

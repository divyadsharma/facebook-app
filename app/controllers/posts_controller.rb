class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update,
                                  :destroy, :upvote, :downvote]
  before_action :owned_post, only: [:edit, :update, :destroy]

  respond_to :html

  def index
    if current_user.active_friends.present? ||
       current_user.received_friends.present? ||
       current_user.present?
      active_users_ids = current_user.active_friends.pluck(:id)
      received_users_ids = current_user.received_friends.pluck(:id)
      user_ids = active_users_ids + received_users_ids + [current_user.id]
      @posts = Post.where(user_id: user_ids).order('created_at DESC')
      @posts.present? && respond_with(@posts)
    end
  end

  def show
    @comments = Comment.where(post_id: @post).order('created_at DESC')
  end

  def new
    @post = current_user.posts.build
    respond_with(@post)
  end

  def edit
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = 'Post created!'
      respond_with(@post)
    else
      flash[:alert] = "Your new post couldn't be created!  Please check the form."
      render :new
    end
  end

  def update
    @post.update(post_params)
    respond_with(@post)
  end

  def destroy
    @post.destroy
    respond_with(@post)
  end

  def upvote
    @post.votes.create
    redirect_to(posts_path)
  end

  # def downvote
  #   @post.votes.create
  #   redirect_to(posts_path)
  # end

  # def upvote
  #   @post.upvote_by current_user
  #   redirect_to posts_path
  # end

  # def downvote
  #   @post.downvote_by current_user
  #   redirect_to posts_path
  # end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end

  def owned_post
    unless current_user == @post.user
      flash[:alert] = "That post doesn't belong to you!"
      redirect_to root_path
    end
  end
end

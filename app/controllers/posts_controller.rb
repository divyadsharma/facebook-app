class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update,
                                  :destroy, :upvote, :downvote, :vote]
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

  def vote
    if !@post.already_upvoted?(current_user) && params[:vote] == 'true'
      vote = Vote.find_by(voteable: @post, creator: current_user, vote: false)
      if vote.present?
        vote.update_attributes(voteable: @post, creator: current_user, vote: params[:vote])
      else
        Vote.create(voteable: @post, creator: current_user, vote: params[:vote])
      end
    elsif !@post.already_downvoted?(current_user) && params[:vote] == 'false'
      vote = Vote.find_by(voteable: @post, creator: current_user, vote: true)
      if vote.present?
        vote.update_attributes(voteable: @post, creator: current_user, vote: params[:vote])
      else
        Vote.create(voteable: @post, creator: current_user, vote: params[:vote])
      end
    end
    redirect_to :back
  end

  # def upvote
  #   @post.votes.create(user_id: @post.user_id) unless already_upvotes?
  #   redirect_to posts_path
  # end

  # def downvote
    
  # end

  # def already_upvotes?
  #   @vote = Vote.find_by(user_id: current_user.id)
  #   @vote.present? ? true : false
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

class CommentsController < ApplicationController
  before_action :find_post
  before_action :find_comment, only: [:destroy, :edit,
                                      :update, :comment_owner,
                                      :vote]
  before_action :comment_owner, only: [:destroy, :edit, :update]
  def create
    @comment = @post.comments.create(comment_params)
    if @comment.errors.present?
      flash[:alert] = "Comment #{@comment.errors[:content].first}"
      redirect_to post_path(@post)
    else
      @comment.user_id = current_user.id
      @comment.save
      if @comment.save
        redirect_to post_path(@post)
      end
    end
  end

  def edit
    
  end

  def update
    if @comment.update(comment_params)
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end

  def destroy
    @comment.destroy
    redirect_to post_path(@post)
  end

  def vote
    if !@comment.already_upvoted?(current_user) && params[:vote] == 'true'
      vote = Vote.find_by(voteable: @comment,
                          creator: current_user,
                          vote: false)
      if vote.present?
        vote.update_attributes(voteable: @comment,
                               creator: current_user,
                               vote: params[:vote])
      else
        Vote.create(voteable: @comment,
                    creator: current_user,
                    vote: params[:vote])
      end
    elsif !@comment.already_downvoted?(current_user) && params[:vote] == 'false'
      vote = Vote.find_by(voteable: @comment, creator: current_user, vote: true)
      if vote.present?
        vote.update_attributes(voteable: @comment,
                               creator: current_user,
                               vote: params[:vote])
      else
        Vote.create(voteable: @comment,
                    creator: current_user,
                    vote: params[:vote])
      end
    end
    redirect_to :back
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def find_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_owner
    unless current_user.id == @comment.user_id
      flash[:alert] = "That comment doesn't belong to you!"
      redirect_to @post
    end
  end
end

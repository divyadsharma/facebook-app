class UpvoteController < ApplicationController
  def create
    @upvote = Upvote.new(secure_params)
    @upvote.post = Post.find(params[:post_id])
    if @upvote.save
      respond_to do |format|
        format.html { redirect_to @upvote.post }
        format.js # we'll use this later for AJAX!
      end
    end
  end

  def destroy
    
  end

  private
  def secure_params
    params.require(:upvote).permit(:user)
  end
end

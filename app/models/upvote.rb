class Upvote < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  belongs_to :comment

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

  private
  def secure_params
    params.require(:upvote).permit(:user)
  end
  # validates :post, uniqueness: { scope: :user }
  # validates :user, uniqueness: { scope: :post }
  # validates :comment, uniqueness: { scope: :post }
end

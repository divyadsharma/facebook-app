class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :title, presence: true
  validates :body, presence: true
  has_many :votes, as: :voteable

  def total_votes
    up_votes + down_votes
  end
  
  def up_votes
    votes.where(vote: true).size
  end
  
  def down_votes
    votes.where(vote: false).size
  end

  def already_upvoted?(user)
    vote = votes.find_by(user_id: user.id, vote: true)
    vote.present? ? true : false
  end

  def already_downvoted?(user)
    vote = votes.find_by(user_id: user.id, vote: false)
    vote.present? ? true : false
  end
end

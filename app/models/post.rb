class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :title, presence: true
  validates :body, presence: true
  has_many :upvotes, dependent: :destroy

  def score
    upvotes.count
  end
  # acts_as_votable
  # validates_presence_of :body, :title
end

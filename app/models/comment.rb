class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  validates :content, presence: true
  has_many :votes, dependent: :destroy
  # acts_as_votable
end

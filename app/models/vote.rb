class Vote < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  belongs_to :comment
end

class PostSub < ActiveRecord::Base
  validates :sub_id, :post_id, presence: true
end

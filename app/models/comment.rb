# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :text             not null
#  author_id  :integer          not null
#  post_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#  parent_id  :integer
#

class Comment < ActiveRecord::Base
  validates :content, :author_id, :post_id, presence: true
  
  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id
  )
  
  belongs_to(
    :post,
    class_name: "Post",
    foreign_key: :post_id,
    primary_key: :id
  )
  
  belongs_to(
    :parent,
    class_name: "Comment",
    foreign_key: :parent_id,
    primary_key: :id
  )
  
  has_many(
    :children,
    class_name: "Comment",
    foreign_key: :parent_id,
    primary_key: :id
  )
end

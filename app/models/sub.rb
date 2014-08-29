# == Schema Information
#
# Table name: subs
#
#  id           :integer          not null, primary key
#  title        :string(255)      not null
#  description  :text
#  moderator_id :integer          not null
#  created_at   :datetime
#  updated_at   :datetime
#

class Sub < ActiveRecord::Base
  validates :title, :moderator_id, presence: true
  validates :title, uniqueness: true
  
  has_many :post_subs, inverse_of: :sub
  
  belongs_to(
    :moderator,
    class_name: "User",
    foreign_key: :moderator_id,
    primary_key: :id
  )
  
  has_many(
    :posts,
    through: :post_subs,
    source: :post
  )
end

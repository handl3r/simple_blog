# == Schema Information
#
# Table name: follows
#
#  id               :bigint           not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  followed_user_id :integer
#  follower_id      :integer
#

class Follow < ApplicationRecord
  belongs_to :follower, foreign_key: :follower_id, class_name: "User"
  belongs_to :followed_user, foreign_key: :followed_user_id, class_name: "User"
end

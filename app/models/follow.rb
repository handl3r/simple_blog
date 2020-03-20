# frozen_string_literal: true

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

# this class for follow relationship
class Follow < ApplicationRecord
  belongs_to :follower, foreign_key: :follower_id, class_name: 'User',
             counter_cache: :followings_count
  belongs_to :followed_user, foreign_key: :followed_user_id, class_name: 'User',
             counter_cache: :followers_count
end

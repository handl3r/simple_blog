# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string(255)
#  name            :string(255)
#  password_digest :string(255)
#  remember_digest :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

class User < ApplicationRecord
  attr_accessor :remember_token

  before_save { email.downcase! }

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP },
                    uniqueness: { case_sensitive: false }
  validates :name, presence: true,  uniqueness: { case_sensitive: false },
                   length: { maximum: 20 }
  validates :password, presence: true, length: { minimum: 3, maximum: 72 }

  has_many :posts
  has_many :received_follows, foreign_key: :followed_user_id, class_name: 'Follow'
  has_many :followers, through: :received_follows, source: :follower
  has_many :given_follows, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followings, through: :given_follows, source: :followed_user

  has_secure_password

  def self.digest(string)
    # set cost to MIN_COST to use for test faster
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(:remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

end

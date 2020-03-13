# == Schema Information
#
# Table name: admins
#
#  id              :bigint           not null, primary key
#  email           :string(255)
#  name            :string(255)
#  password_digest :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Admin < ApplicationRecord
  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 5, maximum: 20 }
  validates :password_digest, presence: true
end

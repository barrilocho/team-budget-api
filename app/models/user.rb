# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string
#  first_name      :string
#  last_name       :string
#  family_id       :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  username        :string
#  password_digest :string
#
class User < ApplicationRecord
  belongs_to :family
  has_many :movements
  has_secure_password

  validates_presence_of :email, :first_name, :last_name, :auth_token

  after_initialize :generate_auth_token

  def generate_auth_token
    unless auth_token.present?
      self.auth_token = TokenGenerationService.generate
    end
  end
end

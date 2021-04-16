# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string
#  first_name :string
#  last_name  :string
#  auth_token :string
#  family_id  :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  belongs_to :family
  has_many :movements
  
  validates :email, presence:true
  validates :first_name, presence:true
  validates :last_name, presence:true
  validates :auth_token, presence:true

  after_initialize :generate_auth_token

  def generate_auth_token
    unless auth_token.present?
      self.auth_token = TokenGenerationService.generate
    end
  end
end

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
  
end

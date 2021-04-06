# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  family_id  :bigint           not null
#  type       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Category < ApplicationRecord
  belongs_to :family
  has_many :movements
  
  validates :name, presence:true
  validates :family_id, presence:true
  validates :type, presence:true
end

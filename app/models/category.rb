# == Schema Information
#
# Table name: categories
#
#  id            :bigint           not null, primary key
#  name          :string
#  family_id     :bigint           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  category_type :integer
#
class Category < ApplicationRecord
  belongs_to :family
  has_many :movements
  
  validates :name, presence:true
  validates :family_id, presence:true
  validates :category_type, presence:true
end

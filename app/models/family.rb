# == Schema Information
#
# Table name: families
#
#  id         :bigint           not null, primary key
#  alias      :string
#  members    :integer
#  balance    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  code       :string
#
class Family < ApplicationRecord
  has_many :users
  has_many :categories

  validates :alias, presence:true
  validates :members, presence:true
  validates :balance, presence:true
  validates :code, presence:true
end

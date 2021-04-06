# == Schema Information
#
# Table name: movements
#
#  id            :bigint           not null, primary key
#  description   :string
#  user_id       :bigint           not null
#  category_id   :bigint           not null
#  movement_date :date
#  amount        :decimal(, )
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Movement < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :description, presence:true
  validates :user_id, presence:true
  validates :category_id, presence:true
  validates :movement_date, presence:true
  validates :amount, presence:true
end

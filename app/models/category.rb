class Category < ApplicationRecord
  belongs_to :family
  has_many :movements
end

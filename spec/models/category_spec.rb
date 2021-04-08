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
require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "Validations" do
    it "validate presence of required fields" do
      should validate_presence_of(:name)
      should validate_presence_of(:family_id)
      should validate_presence_of(:category_type)
    end
    it "validate relations" do
      should have_many(:movements)
    end
  end
end

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
require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "Validations" do
    it "validate presence of required fields" do
      should validate_presence_of(:name)
      should validate_presence_of(:family_id)
      should validate_presence_of(:type)
    end
    it "validate relations" do
      should have_many(:movements)
    end
  end
end

require 'rails_helper'

RSpec.describe Family, type: :model do
  describe "Validations" do
    it "validate presence of required fields" do
      should validate_presence_of(:code)
      should validate_presence_of(:alias)
      should validate_presence_of(:members)
      should validate_presence_of(:balance)
    end
    it "validate relations" do
      should have_many(:users)
      should have_many(:categories)
    end
  end
end

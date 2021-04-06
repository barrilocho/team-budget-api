require 'rails_helper'

RSpec.describe Movement, type: :model do
  describe "Validations" do
    it "validate presence of required fields" do
      should validate_presence_of(:description)
      should validate_presence_of(:user_id)
      should validate_presence_of(:category_id)
      should validate_presence_of(:movement_date)
      should validate_presence_of(:amount)
    end
  end
end

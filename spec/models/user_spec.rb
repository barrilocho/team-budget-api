require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    it "validate presence of required fields" do
      should validate_presence_of(:first_name)
      should validate_presence_of(:last_name)
      should validate_presence_of(:email)
      should validate_presence_of(:auth_token)
      should validate_presence_of(:family_id)
    end
    it "validate relations" do
      should have_many(:movements)
    end
  end
end

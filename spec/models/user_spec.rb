# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string
#  first_name      :string
#  last_name       :string
#  family_id       :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  username        :string
#  password_digest :string
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    it "validate presence of required fields" do
      should validate_presence_of(:first_name)
      should validate_presence_of(:last_name)
      should validate_presence_of(:email)
      should validate_presence_of(:username)
      should validate_presence_of(:password_digest)
    end
    it "validate relations" do
      should have_many(:movements)
    end
  end
end

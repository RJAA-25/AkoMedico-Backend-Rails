require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }

    it "validates presence of first name" do
      user.first_name = nil
      expect(user).to_not be_valid
    end

    it "validates presence of last name" do
      user.last_name = nil
      expect(user).to_not be_valid
    end

    it "validates presence of email" do
      user.email = nil
      expect(user).to_not be_valid
    end

    it "validates format of email" do
      user.email = "invalid_format"
      expect(user).to_not be_valid
    end

    it "validates presence of password" do
      user.password = nil
      user.password_digest = nil
      expect(user).to_not be_valid
    end

    it "validates length of password" do
      user.password = "x" * 5
      expect(user).to_not be_valid

      user.password = "x" * 21
      expect(user).to_not be_valid
    end

    it "validates confirmation of password" do
      user.password_confirmation = "another_password"
      expect(user).to_not be_valid
    end
end
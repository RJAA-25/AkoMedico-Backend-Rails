require 'rails_helper'

RSpec.describe Profile, type: :model do
  let(:profile) { FactoryBot.build(:profile) }

  it "validates presence of birth date" do
    profile.birth_date = nil
    expect(profile).to_not be_valid
  end

  it "validates user is of legal age" do
    profile.birth_date = 18.years.ago + 1.day
    expect(profile).to_not be_valid
  end

  it "validates presence of address" do
    profile.address = nil
    expect(profile).to_not be_valid
  end

  it "validates presence of nationality" do
    profile.nationality = nil
    expect(profile).to_not be_valid
  end

  it "validates presence of civil status" do
    profile.civil_status = nil
    expect(profile).to_not be_valid
  end

  it "validates appropriate selection of civil status" do
    profile.civil_status = "It's complicated"
    expect(profile).to_not be_valid

    profile.civil_status = "Married"
    expect(profile).to be_valid
  end

  it "validates presence of contact number" do
    profile.contact_number = nil
    expect(profile).to_not be_valid
  end

  it "validates presence of height" do
    profile.height = nil
    expect(profile).to_not be_valid
  end

  it "validates presence of weight" do
    profile.weight = nil
    expect(profile).to_not be_valid
  end

  it "validates presence of sex" do
    profile.sex = nil
    expect(profile).to_not be_valid
  end

  it "validates appropriate selection of sex" do
    profile.sex = "alien"
    expect(profile).to_not be_valid

    profile.sex = "Male"
    expect(profile).to be_valid
  end

  it "validates presence of blood_type" do
    profile.blood_type = nil
    expect(profile).to_not be_valid
  end

  it "validates appropriate selection of blood_type" do
    profile.blood_type = "G+"
    expect(profile).to_not be_valid

    profile.blood_type = "AB+"
    expect(profile).to be_valid
  end
end


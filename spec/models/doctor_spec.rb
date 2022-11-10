require 'rails_helper'

RSpec.describe Doctor, type: :model do
  let(:doctor) { FactoryBot.build(:doctor) }

  it "validates presence of first name" do
    doctor.first_name = nil
    expect(doctor).to_not be_valid
  end

  it "validates presence of last name" do
    doctor.last_name = nil
    expect(doctor).to_not be_valid
  end

  it "validates presence of specialty" do
    doctor.specialty = nil
    expect(doctor).to_not be_valid
  end
end

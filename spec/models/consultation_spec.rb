require 'rails_helper'

RSpec.describe Consultation, type: :model do
  let(:consult) { FactoryBot.build(:consultation) }

  it "validates presence of diagnosis" do
    consult.diagnosis = nil
    expect(consult).to_not be_valid
  end

  it "validates presence of health facility" do
    consult.health_facility = nil
    expect(consult).to_not be_valid
  end

  it "validates presence of schedule" do
    consult.schedule = nil
    expect(consult).to_not be_valid
  end

  it "validates schedule not later than current date" do
    consult.schedule = Date.today + 1
    expect(consult).to_not be_valid
  end

  it "validates notes not exceeding limit" do
    consult.notes = "x" * 1001
    expect(consult).to_not be_valid
  end
end

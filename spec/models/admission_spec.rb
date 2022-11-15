require 'rails_helper'

RSpec.describe Admission, type: :model do
  let(:admit) { FactoryBot.build(:admission) }

  # it "validates presence of folder id" do
  #   admit.folder_id = nil
  #   expect(admit).to_not be_valid
  # end

  it "validates presence of diagnosis" do
    admit.diagnosis = nil
    expect(admit).to_not be_valid
  end

  it "validates presence of health facility" do
    admit.health_facility = nil
    expect(admit).to_not be_valid
  end

  it "validates presence of start date" do
    admit.start_date = nil
    expect(admit).to_not be_valid
  end

  it "validates start date not later than current day" do
    admit.start_date = 1.day.from_now
    expect(admit).to_not be_valid
  end

  it "validates presence of end date" do
    admit.end_date = nil
    expect(admit).to_not be_valid
  end 

  it "validates end date not earlier than start date" do
    admit.end_date = 10.days.ago
    expect(admit).to_not be_valid
  end 

  it "validates end date not later current day" do
    admit.end_date = 1.day.from_now
    expect(admit).to_not be_valid
  end

  it "validates notes not exceeding limit" do
    admit.notes = "x" * 1001
    expect(admit).to_not be_valid
  end
end

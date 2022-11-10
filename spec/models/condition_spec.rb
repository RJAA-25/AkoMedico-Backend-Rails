require 'rails_helper'

RSpec.describe Condition, type: :model do
  let(:condition) { FactoryBot.build(:condition) }

  it "validates presence of diagnosis" do
    condition.diagnosis = nil
    expect(condition).to_not be_valid
  end

  it "validates presence of start date" do
    condition.start_date = nil
    expect(condition).to_not be_valid
  end

  it "validates start date later than current day" do
    condition.start_date = 1.day.from_now
    expect(condition).to_not be_valid
  end

  it "validates end date not earlier than start date" do
    condition.end_date = 2.years.ago - 1.day
    expect(condition).to_not be_valid
  end
end
